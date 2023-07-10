require_relative '../../models/init.rb'
require 'sinatra/activerecord'

describe Choice do
  
  # Se crea un nuevo registro en la tabla Difficulty inicializando solo la columna level
  # y se asgina en la instancia @beginner_difficulty   
  before do
    @beginner_difficulty = Difficulty.create(level: :beginner)
  end
  
  describe 'validations' do
    it "is invalid whitout text" do
      choice = Choice.new(difficulty: @beginner_difficulty)
      expect(choice.valid?).to eq(false)
    end

    it "is invalid whitout difficulty" do
      choice = Choice.new(text: "choice question")
      expect(choice.valid?).to eq(false)
    end
  
  end

  describe 'associations' do
    it "has many question_answers" do
      association = described_class.reflect_on_association(:question_answers)
      expect(association.macro).to eq(:has_many)
    end

    it "has many answers" do
      association = described_class.reflect_on_association(:answers)
      expect(association.macro).to eq(:has_many)
    end

    it "belongs to difficulty" do
      association = described_class.reflect_on_association(:difficulty)
      expect(association.macro).to eq(:belongs_to)
    end

  end

end