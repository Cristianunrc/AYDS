require 'sinatra'
require 'bundler/setup'
require 'logger'
require "sinatra/activerecord"
require 'bcrypt'
require 'sinatra/session'
require 'dotenv/load'
require 'securerandom'
require 'enumerize'
# Se cargan explicitamente los modelos
require_relative 'models/user'
require_relative 'models/question'
require_relative 'models/choice'
require_relative 'models/answer'
require_relative 'models/difficulty'
require_relative 'models/trivia'
require_relative 'models/question_answer'
require_relative 'models/true_false'
require_relative 'models/autocomplete'
require_relative 'models/ranking'
require_relative 'models/complaint'

require 'sinatra/reloader' if Sinatra::Base.environment == :development

set :bind, '0.0.0.0'
set :port, ENV['PORT'] || 3000
class App < Sinatra::Application
  def initialize(app = nil)
    super()
  end

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  configure :production, :development do
    enable :logging

    logger = Logger.new(STDOUT)
    logger.level = Logger::DEBUG if development?
    set :logger, logger

    set :public_folder, File.dirname(__FILE__) + '/public'
  end

  configure :development do
    register Sinatra::Reloader
    after_reload do
      puts 'Reloaded...'
    end
  end

  enable :sessions
  set :session_secret, SecureRandom.hex(64)

  before do
    # Verificar si hay una trivia en sesión
    if session[:trivia_id]
      @trivia = Trivia.find_by(id: session[:trivia_id])
      redirect '/trivia' if @trivia.nil?  # Redirigir si la trivia no existe
    end
  end

  get '/' do
    erb :index
  end

  get '/registrarse' do
    erb :register
  end

  get '/login' do
    erb :login
  end

  post '/registrarse' do
    # Obtener los datos del formulario
    username = params[:username]
    email = params[:email]
    password = params[:password]
    confirm_password = params[:confirm_password]

    if password == confirm_password # se verifica si los passwords coinciden
      if User.exists?(username: username) # se verifica si el nombre de usuario ya existe en la BD
        redirect "/error?code=registration&reason=username_taken"
      elsif User.exists?(email: email) # se verifica si el email ya existe en la base de datos
        redirect "/error?code=registration&reason=email_taken"
      else
        # Crear un nuevo registro en la base de datos
        user = User.create(username: username, email: email, password: password)
        if user.save
          @message = "Excelente! Ahora dirigase al inicio de sesión."
          erb :register_success
        else
          redirect "/error?code=registration&reason=registration_error&error_message=#{CGI.escape(user.errors.full_messages.join(', '))}"
        end
      end
    else
      redirect "/error?code=registration&reason=password_mismatch"
    end
  end

   post '/login' do
    # Obtener los datos del formulario
    username = params[:username]
    password = params[:password]
    user = User.find_by(username: username) # En la tabla User se busca un registro con el nombre del usuario
    if user && user.authenticate(password) # si user existe y el password es correcto
      session[:user_id] = user.id # El id del usuario se almacena en la session
      redirect '/protected_page'
    else
      redirect "/error?code=login&reason=authenticate_failed"
    end
  end

  get '/protected_page' do
    if session[:user_id]
      user_id = session[:user_id]
      @username = User.find(user_id).username # en @username se almacena el nombre de usuario logeado
      # Obtener los rankings
      beginner_difficulty = Difficulty.find_by(level: "beginner")
      difficult_difficulty = Difficulty.find_by(level: "difficult")

      beginner_ranking = Ranking.where(difficulty_id: beginner_difficulty.id).order(score: :desc).limit(10)
      difficult_ranking = Ranking.where(difficulty_id: difficult_difficulty.id).order(score: :desc).limit(10)

      erb :protected_page, locals: { beginner_ranking: beginner_ranking, difficult_ranking: difficult_ranking }
    else
      redirect '/login' # Usuario no autenticado, redirigir a la página de inicio de sesión
    end
  end

  get '/reclamo' do
    erb :complaint
  end

  post '/reclamo' do
    user_id = session[:user_id] # almaceno el id del usuario logueado 
    description_text = params[:description] # almaceno el texto del reclamo (la entrada es name="description")
    complaint = Complaint.create(description: description_text, user_id: user_id)
    if complaint.save
      redirect '/protected_page'
    end
  end

  get '/learnToGame' do
    erb :learnToGame
  end
    
  post '/trivia' do
    user = current_user
    difficulty_level = params[:difficulty]
    difficulty = Difficulty.find_by(level: difficulty_level)
    trivia = Trivia.new(user: user, difficulty: difficulty)

    if difficulty_level == "beginner"
      choice_count = rand(3..6)
      true_false_count = rand(3..4)
    else # difficulty_level == "difficult"
      choice_count = rand(2..5)
      true_false_count = rand(2..4)
    end  
      
    remaining_count = 10 - choice_count - true_false_count
    autocomplete_count = [remaining_count, 0].max

    choice_questions = difficulty.questions.where(type: 'Choice').order("RANDOM()").limit(choice_count)
    true_false_questions = difficulty.questions.where(type: 'True_False').order("RANDOM()").limit(true_false_count)
    autocomplete_questions = difficulty.questions.where(type: 'Autocomplete').order("RANDOM()").limit(autocomplete_count)

    questions = choice_questions.to_a + true_false_questions.to_a + autocomplete_questions.to_a
    shuffled_questions = questions.shuffle # se mezclan las preguntas con metodo shuffle
    trivia.questions.concat(shuffled_questions) # se concatenan las preguntas

    trivia.save
    session[:trivia_id] = trivia.id
    session[:answered_questions] = []
    redirect '/question/0'
  end

  get '/question/:index' do
    redirect '/trivia' if @trivia.nil?  # Redirigir si no hay una trivia en sesión

    index = params[:index].to_i #convierte el parametro index en un entero y se guarda en la variable index
    question = @trivia.questions[index] # se obtiene la pregunta con su index y se almacena en question
    previous_index = index.zero? ? 0 : index - 1

    if index.zero? || session[:answered_questions].include?(previous_index)
      if question.nil? || index >= 10
        redirect '/results' # Redirigir a los resultados si no hay más preguntas
      else
        @question = question
        @answers = Answer.where(question_id: question.id)
        @time_limit_seconds = @trivia.difficulty.level == "beginner" ? 35 : 20
        @question_index = index # Inicializar @question_index con el valor de index
        @help = @trivia.difficulty.level == "beginner" ? question.help : nil
        erb :question, locals: { question: @question, trivia: @trivia, question_index: @question_index, answers: @answers, time_limit_seconds: @time_limit_seconds, help: @help}
      end
    else
      redirect "/error?code=unanswered"
    end
  end

  post '/answer/:index' do
    redirect '/trivia' if @trivia.nil?  # Redirigir si no hay una trivia en sesión

    index = params[:index].to_i
    question = @trivia.questions[index]

    if question.nil? || index >= 10
      redirect '/results' # Redirigir a los resultados si no hay más preguntas
    else
      selected_answer_id = params[:selected_answer]
      selected_answer = Answer.find_by(id: selected_answer_id, question_id: question.id)

      if selected_answer.nil? && !question.is_a?(Autocomplete)
        session[:answered_questions] << index
        redirect "/question/#{index + 1}"
      elsif session[:answered_questions].include?(index)
        redirect '/error?code=answered'
      else
        # Crear un nuevo registro en la tabla QuestionAnswer con los IDs de la pregunta y la respuesta seleccionada
        session[:answered_questions] << index # Agregar el índice de la pregunta respondida a la lista
        question_answer = QuestionAnswer.find_or_initialize_by(question_id: question.id, trivia_id: @trivia.id)
        if !selected_answer.nil?
          question_answer.answer_id = selected_answer.id
          question_answer.save
          selected_answer.update(selected: true)
        end

        # Agregar manejo de respuestas para preguntas de autocompletado
        autocomplete_input = params[:autocomplete_input].to_s.strip
        if question.is_a?(Autocomplete)
          answer_autocomplete = Answer.find_by(question_id: question.id)
          answer_autocomplete.update(autocomplete_input: autocomplete_input)
        end

        total_time = @trivia.difficulty == "beginner" ? 35 : 20
        var_response_time = total_time - params[:response_time].to_i
        question_answer&.update(response_time: var_response_time)
        next_index = index + 1
        redirect "/question/#{next_index}"
      end
    end
  end # end post

  get '/error' do
    error_code = params[:code]
    error_reason = params[:reason]
    @error_message = "Ha ocurrido un error."
    
    # Manejo de errores para las preguntas de la trivia
    if error_code == "unanswered"
      @error_message = "Se intentó acceder directamente a una pregunta sin haber respondido la pregunta anterior."
    end

    if error_code == "answered"
      @error_message = "La pregunta ya ha sido respondida."
    end

    # Manejo de errores para el registro de usuario
    if error_code == "registration"
      if error_reason == "password_mismatch"
        @error_message = "Las contraseñas no coinciden."
      end

      if error_reason == "registration_error"
        @error_message = "Ha ocurrido un error durante el registro: #{params[:error_message]}"
      end

      if error_reason == "username_taken"
        @error_message = "El nombre de usuario no está disponible."
      end

      if error_reason == "email_taken"
        @error_message = "El email no está disponible."
      end
    end
    
    # Manejo de errores para el inicio de sesion de usuario
    if error_code == "login"
      if error_reason == "authenticate_failed"
        @error_message = "El usuario o la contraseña no coinciden. Por favor, vuelva a intentarlo."
      end
    end

    erb :error, locals: { error_message: @error_message }
  end

  get '/results' do
    redirect '/trivia' if @trivia.nil?  # Redirigir si no hay una trivia en sesión

    @user = @trivia.user
    @results = []
    @score = 0
    @idx = 0
    response_time_limit = @trivia.difficulty == 'beginner'? 35 : 20

    @trivia.question_answers.each do |question_answer|
      question = question_answer.question
      selected_answer = Answer.find_by(id: question_answer.answer_id, question_id: question_answer.question_id)
      correct_answer = Answer.find_by(question_id: question_answer.question_id, correct: true)

      result = {
        question: question,
        selected_answer: selected_answer,
        correct_answer: correct_answer,
        correct: false,
        autocomplete_input: nil
      }

      if question.is_a?(Autocomplete)
        answer = Answer.find_by(question_id: question.id)
        result[:correct] = answer.answers_autocomplete.include?(answer.autocomplete_input)
        result[:autocomplete_input] = answer.autocomplete_input
        result[:correct_answer] = answer.answers_autocomplete[0]
      else
        result[:correct] = selected_answer == correct_answer
      end

      @results << result
      # Calcular el puntaje basado en el tiempo de respuesta solo si la respuesta seleccionada es correcta
      if result[:correct] && question_answer.response_time <= response_time_limit
        response_time_score = calculate_response_time_score(question_answer.response_time, response_time_limit)
        @score += response_time_score
      else
        @score += 0
      end

    end # end do

    # Logica para el ranking
    user = current_user
    difficulty = @trivia.difficulty
    # Se busca el ranking del usuario (si es que existe) con la dificultad actual
    ranking = Ranking.find_by(user_id: user.id, difficulty_id: difficulty.id)

    # Si no existe un ranking o el score actual es mayor (o menor) al que estaba, entonces se actualiza.
    if ranking.nil? || @score > ranking.score || @score < ranking.score
      ranking = Ranking.find_or_initialize_by(user_id: user.id, difficulty_id: difficulty.id)
      ranking.score = @score
      ranking.difficulty = difficulty
      ranking.save
    end
 
    if @score < 30
      @message_results = "¡No obtuviste un buen resultado! Pero sigue intentandolo"
    elsif @score >= 30 && @score < 60   
      @message_results = "¡Falta mejorar un poquito! Estas avanzando"
    else # score >= 60
      @message_results = "¡Muy bien jugado! Felicitaciones"  
    end

    erb :results, locals: { results: @results, score: @score, message_results: @message_results}
    end

    private 
    def calculate_response_time_score(response_time, response_time_limit)
      max_score = 10 # puntuación máxima de 10 puntos para una respuesta correcta
      # Si el nivel es 'beginner', se resta 1 pto por cada 5 segundo que se tarda en responder
      if response_time_limit == 35
        points_to_subtract = [(response_time / 5).ceil, 3].min
      else # Si el nivel no es 'beginner', se resta 1 pto por cada 4 segundos que se tarda en responder
      points_to_subtract = [(response_time / 4).ceil, 3].min
      end
      # Se calcula la puntuacion final y se asegura de que este en el rango entre 0 y max_score
      final_score = max_score - points_to_subtract
      final_score.clamp(0, max_score)
    end
  end # end get
