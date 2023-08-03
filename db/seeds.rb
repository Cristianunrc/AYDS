
ActiveRecord::Base.connection.execute('PRAGMA foreign_keys = OFF;')
if ENV['RACK_ENV'] == 'development'
  # Eliminar los registros existentes antes de crear nuevos
  [Question, Answer, Difficulty].each(&:destroy_all)
end
ActiveRecord::Base.connection.execute('PRAGMA foreign_keys = ON;')

beginner_difficulty = Difficulty.create!(level: "beginner")
difficult_difficulty = Difficulty.create!(level: "difficult")

=begin

POR CONVENCION:
Preguntas principiantes: 1) Choices -> choice_pri_numero
                         2) True_Falses -> true_false_pri_numero
                         3) Autocompletes -> autocomplete_pri_numero

Preguntas expertas: 1) Choices -> choice_exp_numero
                    2) True_Falses -> true_false_exp_numero
                    3) Autocompletes -> autocomplete_exp_numero
=end

Question.transaction do

  # PREGUNTAS NIVEL PRINCIPIANTE

  # Pregunta 1
  choice_pri_1 = Choice.create!(
    text: "¿Qué es un compilador?",
    help: "Proceso de conversión.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: choice_pri_1,
    text: "Un programa que convierte el código fuente a lenguaje máquina o código binario.",
    correct: true
  )

  Answer.create!(
    question: choice_pri_1,
    text: "Un dispositivo que permite la comunicación entre computadoras.",
    correct: false
  )

  Answer.create!(
    question: choice_pri_1,
    text: "Un componente físico de una computadora.",
    correct: false
  )

  Answer.create!(
    question: choice_pri_1,
    text: "Un programa para diseñar interfaces gráficas de usuario.",
    correct: false
  )

  # Pregunta 2
  choice_pri_2 = Choice.create!(
    text: "¿Cuál de las siguientes opciones NO es un lenguaje de programación?",
    help: "Lenguaje de consulta.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: choice_pri_2,
    text: "Prolog",
    correct: false
  )

  Answer.create!(
    question: choice_pri_2,
    text: "Java",
    correct: false
  )

  Answer.create!(
    question: choice_pri_2,
    text: "Ruby",
    correct: false
  )

  Answer.create!(
    question: choice_pri_2,
    text: "SQL",
    correct: true
  )

  # Pregunta 3
  choice_pri_3 = Choice.create!(
    text: "¿Qué es el overclocking?",
    help: "Mayor frecuencia.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: choice_pri_3,
    text: "Ejecutar un programa de manera más eficiente utilizando menos recursos.",
    correct: false
  )

  Answer.create!(
    question: choice_pri_3,
    text: "Crear una copia de seguridad de los datos en un medio externo.",
    correct: false
  )

  Answer.create!(
    question: choice_pri_3,
    text: "Aumentar la velocidad de un componente de hardware más allá de las especificaciones del fabricante.",
    correct: true
  )

  Answer.create!(
    question: choice_pri_3,
    text: "Desarrollar software utilizando métodos ágiles.",
    correct: false
  )

  # Pregunta 4
  choice_pri_4 = Choice.create!(
    text: "¿Qué es un algoritmo?",
    help: "Estructurado, organizado.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: choice_pri_4,
    text: "Un dispositivo que permite almacenar y recuperar información.",
    correct: false
  )

  Answer.create!(
    question: choice_pri_4,
    text: "Una serie de instrucciones bien escritas en una computadora para resolver un problema o realizar una tarea.",
    correct: true
  )

  Answer.create!(
    question: choice_pri_4,
    text: "Un lenguaje de programación utilizado para el desarrollo web.",
    correct: false
  )

  Answer.create!(
    question: choice_pri_4,
    text: "Ninguna de las opciones anteriores.",
    correct: false
  )

  # Pregunta 5
  choice_pri_5 = Choice.create!(
    text: "¿Qué es el machine learning o aprendizaje de máquina?",
    help: "Aprendizaje.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: choice_pri_5,
    text: "Una rama de la inteligencia artificial que permite a las máquinas aprender y tomar decisiones.",
    correct: true
  )

  Answer.create!(
    question: choice_pri_5,
    text: "Un enfoque de desarrollo de software que utiliza pruebas automatizadas.",
    correct: false
  )

  Answer.create!(
    question: choice_pri_5,
    text: "Una técnica para asegurar la calidad del software.",
    correct: false
  )

  Answer.create!(
    question: choice_pri_5,
    text: "Un método para el desarrollo de aplicaciones web.",
    correct: false
  )

   # Pregunta 6
   choice_pri_6 = Choice.create!(
    text: "¿Qué es un bucle o ciclo?",
    help: "Repeticiones.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: choice_pri_6,
    text: "Una técnica para verificar la corrección de un programa.",
    correct: false
  )

  Answer.create!(
    question: choice_pri_6,
    text: "Un tipo de dato utilizado para almacenar texto.",
    correct: false
  )

  Answer.create!(
    question: choice_pri_6,
    text: "Un método para organizar y almacenar datos en una estructura jerárquica.",
    correct: false
  )

  Answer.create!(
    question: choice_pri_6,
    text: "Una estructura de control que repite un bloque de código varias veces.",
    correct: true
  )

  # Pregunta 7
  choice_pri_7 = Choice.create!( 
    text: "¿Qué es un algoritmo de búsqueda?",
    help: "Buscar algo especifico.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: choice_pri_7,
    text: "Una forma de organizar y estructurar el código fuente de un programa.",
    correct: false
  )

  Answer.create!(
    question: choice_pri_7,
    text: "Un conjunto de pasos para encontrar un elemento específico dentro de una colección de datos.",
    correct: true
  )

  Answer.create!(
    question: choice_pri_7,
    text: "Un método para optimizar el rendimiento de un programa.",
    correct: false
  )

  Answer.create!(
    question: choice_pri_7,
    text: "Una técnica para garantizar la seguridad de un sistema informático.",
    correct: false
  )

  # Pregunta 8
  choice_pri_8 = Choice.create!( 
    text: "¿Qué es el debugging?",
    help: "Búsqueda y solución.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: choice_pri_8,
    text: "Una metodología para el desarrollo ágil de software.",
    correct: false
  )

  Answer.create!(
    question: choice_pri_8,
    text: "Un tipo de lenguaje de programación orientado a objetos.",
    correct: false
  )

  Answer.create!(
    question: choice_pri_8,
    text: "Una técnica para encontrar errores en un programa.",
    correct: true
  )

  Answer.create!(
    question: choice_pri_8,
    text: "Un método para realizar pruebas automatizadas en un programa.",
    correct: false
  )

  # Pregunta 9
  choice_pri_9 = Choice.create!( 
    text: "¿Qué es un repositorio de código?",
    help: "Alojar código.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: choice_pri_9,
    text: "Un lugar donde se almacena y gestiona el código fuente de un proyecto.",
    correct: true
  )

  Answer.create!(
    question: choice_pri_9,
    text: "Un tipo de estructura de datos utilizada para almacenar y organizar información.",
    correct: false
  )

  Answer.create!(
    question: choice_pri_9,
    text: "Una técnica para proteger un programa contra posibles vulnerabilidades.",
    correct: false
  )

  Answer.create!(
    question: choice_pri_9,
    text: "Un método para optimizar el rendimiento de un programa.",
    correct: false
  )

  # Pregunta 10
  choice_pri_10 = Choice.create!( 
    text: "¿Qué es un framework?",
    help: "Lugar donde se almacenan libros.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: choice_pri_10,
    text: "Un lenguaje de programación.",
    correct: false
  )

  Answer.create!(
    question: choice_pri_10,
    text: "Una técnica para el diseño de interfaces de usuario.",
    correct: false
  )

  Answer.create!(
    question: choice_pri_10,
    text: "Una técnica para resolver problemas de programación.",
    correct: false
  )

  Answer.create!(
    question: choice_pri_10,
    text: "Un conjunto de herramientas y bibliotecas que facilitan el desarrollo de aplicaciones.",
    correct: true
  )

  #Pregunta 11
  choice_pri_11 = Choice.create!( 
    text: "¿Cuál de los siguientes lenguajes de programación es funcional?",
    help: "Todos los lenguajes de programación funcional son antiguos.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: choice_pri_11,
    text: "LISP",
    correct: false
  )

  Answer.create!(
    question: choice_pri_11,
    text: "Haskell",
    correct: false
  )

  Answer.create!(
    question: choice_pri_11,
    text: "ML",
    correct: false
  )

  Answer.create!(
    question: choice_pri_11,
    text: "Todos",
    correct: true
  )

  #Pregunta 12
  choice_pri_12 = Choice.create!( 
    text: "¿Cómo funcionan los métodos encolar y desencolar de una Cola de Prioridad?",
    help: "Los elementos en una cola de prioridad están ordenados.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: choice_pri_12,
    text: "Se encola un elemento al final y se desencola un elemento al principio.",
    correct: false
  )

  Answer.create!(
    question: choice_pri_12,
    text: "Se encola un elemento al medio y se desencola el mismo elemento.",
    correct: false
  )

  Answer.create!(
    question: choice_pri_12,
    text: "Se encola un elemento con una cierta prioridad y se desencola un elemento al principio.",
    correct: true
  )

  Answer.create!(
    question: choice_pri_12,
    text: "Ninguna de las opciones anteriores.",
    correct: false
  )

  # Preguntas nivel principiante - TRUE FALSE

  # Pregunta 1
  true_false_pri_1 = True_False.create!( 
    text: "En un lenguaje con TIPADO DINÁMICO se declaran los tipos de las variables, ejemplo: int x = 10;",
    help: "Los lenguajes con tipado dinámico no tienen declaración de tipos.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: true_false_pri_1,
    text: "Verdadero",
    correct: false
  )

  Answer.create!(
    question: true_false_pri_1,
    text: "Falso",
    correct: true
  )

  # Pregunta 2
  true_false_pri_2 = True_False.create!( 
    text: "Los errores en tiempo de compilación son más fáciles de encontrar que los errores en tiempo de ejecución",
    help: "Es costoso localizar el error en tiempo de ejecución.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: true_false_pri_2,
    text: "Verdadero",
    correct: true
  )

  Answer.create!(
    question: true_false_pri_2,
    text: "Falso",
    correct: false
  )

  # Pregunta 3
  true_false_pri_3 = True_False.create!( 
    text: "Un prototipo es una representación de un futuro producto tecnológico.",
    help: "Cuando se desarrolla un avión, es muy útil crear prototipos.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: true_false_pri_3,
    text: "Verdadero",
    correct: true
  )

  Answer.create!(
    question: true_false_pri_3,
    text: "Falso",
    correct: false
  )

  # Pregunta 5
  true_false_pri_4 = True_False.create!( 
    text: "Un TERA BYTE es equivalente a mil GIGA BYTES",
    help: "Mil MEGA BYTES equivalen a un GIGA BYTE.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: true_false_pri_4,
    text: "Verdadero",
    correct: true
  )

  Answer.create!(
    question: true_false_pri_4,
    text: "Falso",
    correct: false
  )

  true_false_pri_5 = True_False.create!( 
    text: "El sistema operativo Linux se basa en el núcleo Windows.",
    help: "Linux es un núcleo o kernel libre.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: true_false_pri_5,
    text: "Verdadero",
    correct: false
  )

  Answer.create!(
    question: true_false_pri_5,
    text: "Falso",
    correct: true
  )

  true_false_pri_6 = True_False.create!( 
    text: "La inteligencia artificial es capaz de simular el pensamiento humano.",
    help: "La inteligencia artificial no puede pensar.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: true_false_pri_6,
    text: "Verdadero",
    correct: true
  )

  Answer.create!(
    question: true_false_pri_6,
    text: "Falso",
    correct: false
  )

  true_false_pri_7 = True_False.create!( 
    text: "El lenguaje de programación Java es un lenguaje interpretado.",
    help: "Mediante un proceso, un archivo fuente de java se convierte en un archivo ejecutable.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: true_false_pri_7,
    text: "Verdadero",
    correct: false
  )

  Answer.create!(
    question: true_false_pri_7,
    text: "Falso",
    correct: true
  )

  true_false_pri_8 = True_False.create!( 
    text: "El protocolo HTTP significa Hypertext Transfer Protocol.",
    help: "Cuando ingresas a una página web, ésta comienza con http.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: true_false_pri_8,
    text: "Verdadero",
    correct: true
  )

  Answer.create!(
    question: true_false_pri_8,
    text: "Falso",
    correct: false
  )

  true_false_pri_9 = True_False.create!( 
    text: "El lenguaje de programación Ruby fue creado en Japón.",
    help: "Su creador es Yukihiro Matsumoto",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: true_false_pri_9,
    text: "Verdadero",
    correct: true
  )

  Answer.create!(
    question: true_false_pri_9,
    text: "Falso",
    correct: false
  )

  true_false_pri_10 = True_False.create!( 
    text: "El disco duro forma parte del HARDWARE de una computadora.",
    help: "El hardware está formado por los componentes físicos de una computadora.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: true_false_pri_10,
    text: "Verdadero",
    correct: true
  )

  Answer.create!(
    question: true_false_pri_10,
    text: "Falso",
    correct: false
  )

  # Preguntas AUTOCOMPLETADO, nivel principiante

  # Pregunta 1
  autocomplete_pri_1 = Autocomplete.create!( 
    text: "El primer ordenador electrónico fue construido en el año _ _ _ _ _ _ _ . ",
    help: "Después de la segunda guerra mundial, entre el año 1945 y 1950.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: autocomplete_pri_1,
    answers_autocomplete: ["1946"]
  )

  # Pregunta 2
  autocomplete_pri_2 = Autocomplete.create!( 
    text: "El primer teléfono móvil comercial se lanzó en el año _ _ _ _ _ _ _ . ",
    help: "Un año que está entre 1980 y 1990.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: autocomplete_pri_2,
    answers_autocomplete: ["1983"]
  )

  # Pregunta 3
  autocomplete_pri_3 = Autocomplete.create!( 
    text: "El lenguaje de programación más utilizado en el desarrollo web es _ _ _ _ _ _ _ .",
    help: "Es un lenguaje hijo del lenguaje JAVA.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: autocomplete_pri_3,
    answers_autocomplete: ["JavaScript", "javascript", "Javascript", "java script", "javaScript"]
  )

  # Pregunta 4
  autocomplete_pri_4 = Autocomplete.create!( 
    text: "La arquitectura de computadoras se encarga del diseño y desarrollo del _ _ _ _ _ _ _ .",
    help: "Lo opuesto al SOFTWARE.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: autocomplete_pri_4,
    answers_autocomplete: ["Hardware", "hardware"]
  )

  # Pregunta 5
  autocomplete_pri_5 = Autocomplete.create!( 
    text: "El sistema operativo más utilizado en dispositivos móviles es _ _ _ _ _ _ _ .",
    help: "Similar a la palabra ANDROIDE.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: autocomplete_pri_5,
    answers_autocomplete: ["Android", "android"]
  )

  # Pregunta 6
  autocomplete_pri_6 = Autocomplete.create!( 
    text: "La RAM (Random Acces Memory) es la memoria _ _ _ _ _ _ _ de una computadora.",
    help: "Palabra que está entre primaria y terciaria.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: autocomplete_pri_6,
    answers_autocomplete: ["secundaria", "Secundaria", "SECUNDARIA"]
  )

  # Pregunta 7
  autocomplete_pri_7 = Autocomplete.create!( 
    text: "El algoritmo de ordenamiento más conocido y eficiente es _ _ _ _ _ _ _ .",
    help: "Ordenamiento rápido.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: autocomplete_pri_7,
    answers_autocomplete: ["Quicksort", "quicksort"]
  )

  # Pregunta 8
  autocomplete_pri_8 = Autocomplete.create!( 
    text: "El sistema de gestión de bases de datos más popular es _ _ _ _ _ _ _ .",
    help: "Es un lenguaje de consulta.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: autocomplete_pri_8,
    answers_autocomplete: ["MySQL", "mysql", "MYSQL"]
  )

  # Pregunta 9
  autocomplete_pri_9 = Autocomplete.create!( 
    text: "El término utilizado para describir el conjunto de instrucciones ejecutadas por un ordenador es _ _ _ _ _ _ _ .",
    help: "Lo que se obtiene de la implementación de un algoritmo.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: autocomplete_pri_9,
    answers_autocomplete: ["Programa", "programa"]
  )

  # Pregunta 10
  autocomplete_pri_10 = Autocomplete.create!( 
    text: "El proceso de convertir el código fuente en un programa ejecutable se conoce como _ _ _ _ _ _ _ .",
    help: "Similar a interpretación.",
    difficulty: beginner_difficulty
  )

  Answer.create!(
    question: autocomplete_pri_10,
    answers_autocomplete: ["Compilación", "compilación", "compilacion", "Compilacion"]
  )

  ####################################################################

  # PREGUNTAS NIVEL EXPERTO (CHOICE)

  # Pregunta 1
  choice_exp_1 = Choice.create!( 
    text: "¿Cómo se llamó la primer computadora construida?",
    difficulty: difficult_difficulty
  )

  Answer.create!(
    question: choice_exp_1,
    text: "SKYNET",
    correct: false
  )

  Answer.create!(
    question: choice_exp_1,
    text: "ENIAC",
    correct: true
  )

  Answer.create!(
    question: choice_exp_1,
    text: "EDVAC",
    correct: false
  )

  Answer.create!(
    question: choice_exp_1,
    text: "IBM 650",
    correct: false
  )

  # Pregunta 2
  choice_exp_2 = Choice.create!( 
    text: "¿Cuál de los siguientes lenguajes tiene NOCION DE ESTADO?",
    difficulty: difficult_difficulty
  )

  Answer.create!(
    question: choice_exp_2,
    text: "C++",
    correct: false
  )

  Answer.create!(
    question: choice_exp_2,
    text: "RUBY",
    correct: false
  )

  Answer.create!(
    question: choice_exp_2,
    text: "PYTHON",
    correct: false
  )

  Answer.create!(
    question: choice_exp_2,
    text: "Todas las opciones.",
    correct: true
  )

  # Pregunta 3
  choice_exp_3 = Choice.create!( 
    text: "¿Cuántos BITS hacen falta para representar 1 BYTE?",
    difficulty: difficult_difficulty
  )

  Answer.create!(
    question: choice_exp_3,
    text: "4 BITS",
    correct: false
  )

  Answer.create!(
    question: choice_exp_3,
    text: "6 BITS",
    correct: false
  )

  Answer.create!(
    question: choice_exp_3,
    text: "8 BITS",
    correct: true
  )

  Answer.create!(
    question: choice_exp_3,
    text: "Ninguna de las opciones.",
    correct: false
  )

  # Pregunta 4
  choice_exp_4 = Choice.create!( 
    text: "¿Cuál es el mejor tiempo de ejecución para un algoritmo?",
    difficulty: difficult_difficulty
  )

  Answer.create!(
    question: choice_exp_4,
    text: "Factorial",
    correct: false
  )

  Answer.create!(
    question: choice_exp_4,
    text: "Lineal",
    correct: false
  )

  Answer.create!(
    question: choice_exp_4,
    text: "Logarítmico",
    correct: false
  )

  Answer.create!(
    question: choice_exp_4,
    text: "Constante",
    correct: true
  )

  # Pregunta 5
  choice_exp_5 = Choice.create!( 
    text: "¿Qué hace el algoritmo de Dijkstra?",
    difficulty: difficult_difficulty
  )

  Answer.create!(
    question: choice_exp_5,
    text: "Calcula las distancias más largas entre los nodos.",
    correct: false
  )

  Answer.create!(
    question: choice_exp_5,
    text: "Calcula las distancias más cortas entre los nodos.",
    correct: true
  )

  Answer.create!(
    question: choice_exp_5,
    text: "Calcula las distancias negativas entre los nodos.",
    correct: false
  )

  Answer.create!(
    question: choice_exp_5,
    text: "Todas las opciones.",
    correct: false
  )

  # Pregunta 6
  choice_exp_6 = Choice.create!( 
    text: "¿Cuál de los siguientes criterios tiene la prueba de CAJA BLANCA?",
    difficulty: difficult_difficulty
  )

  Answer.create!(
    question: choice_exp_6,
    text: "Cobertura de sentencias.",
    correct: true
  )

  Answer.create!(
    question: choice_exp_6,
    text: "Clases de equivalencia.",
    correct: false
  )

  Answer.create!(
    question: choice_exp_6,
    text: "Tablas de desición.",
    correct: false
  )

  Answer.create!(
    question: choice_exp_6,
    text: "Todas las opciones son correctas.",
    correct: false
  )

  # Pregunta 7
  choice_exp_7 = Choice.create!( 
    text: "¿Quién fue Alan Turing?",
    difficulty: difficult_difficulty
  )

  Answer.create!(
    question: choice_exp_7,
    text: "El creador de microsoft.",
    correct: false
  )

  Answer.create!(
    question: choice_exp_7,
    text: "Un actor.",
    correct: false
  )

  Answer.create!(
    question: choice_exp_7,
    text: "Descubrió como funciona la máquina Enigma.",
    correct: true
  )

  Answer.create!(
    question: choice_exp_7,
    text: "Ninguna opción es correcta.",
    correct: false
  )

  choice_exp_8 = Choice.create!( 
    text: "¿Cuál de los siguientes lenguajes de programación es funcional?",
    difficulty: difficult_difficulty
  )

  Answer.create!(
    question: choice_exp_8,
    text: "Python",
    correct: false
  )

  Answer.create!(
    question: choice_exp_8,
    text: "C++",
    correct: false
  )

  Answer.create!(
    question: choice_exp_8,
    text: "Haskell",
    correct: true
  )

  Answer.create!(
    question: choice_exp_8,
    text: "Java",
    correct: false
  )

  choice_exp_9 = Choice.create!( 
    text: "¿Cuál de las siguientes funciones describe la COMPLEJIDAD TEMPORAL del algoritmo de ordenamiento QuickSort?",
    difficulty: difficult_difficulty
  )

  Answer.create!(
    question: choice_exp_9,
    text: "Función lineal: Orden (n)",
    correct: false
  )

  Answer.create!(
    question: choice_exp_9,
    text: "Función logarítmica: Orden (n * log (n))",
    correct: true
  )

  Answer.create!(
    question: choice_exp_9,
    text: "Función cuadrática: Orden (n ^ 2)",
    correct: false
  )

  Answer.create!(
    question: choice_exp_9,
    text: "Función logarítmica: Orden (log (n))",
    correct: false
  )

  choice_exp_10 = Choice.create!( 
    text: "¿Cuál de los siguientes sistemas operativos no está basado en el núcleo Linux?",
    difficulty: difficult_difficulty
  )

  Answer.create!(
    question: choice_exp_10,
    text: "Ubuntu",
    correct: false
  )

  Answer.create!(
    question: choice_exp_10,
    text: "Android",
    correct: false
  )

  Answer.create!(
    question: choice_exp_10,
    text: "Windows",
    correct: true
  )

  Answer.create!(
    question: choice_exp_10,
    text: "Fedora",
    correct: false
  )

  choice_exp_11 = Choice.create!( 
    text: "¿Cuál de los siguientes conceptos está relacionado con el principio SOLID?",
    difficulty: difficult_difficulty
  )

  Answer.create!(
    question: choice_exp_11,
    text: "Programación estructurada",
    correct: false
  )

  Answer.create!(
    question: choice_exp_11,
    text: "Programación orientada a objetos",
    correct: true
  )

  Answer.create!(
    question: choice_exp_11,
    text: "Programación funcional",
    correct: false
  )

  Answer.create!(
    question: choice_exp_11,
    text: "Programación concurrente",
    correct: false
  )

  #Preguntas nivel experto - TRUE FALSE

   # Pregunta 1
  true_false_exp_1 = True_False.create!( 
    text: "El orden de evaluación del lenguaje Haskell es Orden Aplicativo.",
    difficulty: difficult_difficulty
  )

  Answer.create!(
    question: true_false_exp_1,
    text: "Verdadero",
    correct: false
  )

  Answer.create!(
    question: true_false_exp_1,
    text: "Falso",
    correct: true
  )

  # Pregunta 2
  true_false_exp_2 = True_False.create!( 
    text: "La estructura de datos ARREGLOS, tiene acceso secuencial y directo a sus elementos.",
    difficulty: difficult_difficulty
  )

  Answer.create!(
    question: true_false_exp_2,
    text: "Verdadero",
    correct: true
  )

  Answer.create!(
    question: true_false_exp_2,
    text: "Falso",
    correct: false
  )

  # Pregunta 3
  true_false_exp_3 = True_False.create!( 
    text: "La memoria RAM pierde toda su información almacenada cuando se apaga la computadora.",
    difficulty: difficult_difficulty
  )

  Answer.create!(
    question: true_false_exp_3,
    text: "Verdadero",
    correct: true
  )

  Answer.create!(
    question: true_false_exp_3,
    text: "Falso",
    correct: false
  )

  true_false_exp_4 = True_False.create!( 
    text: "El lenguaje HTML es el lenguaje estándar en el desarrollo de aplicaciones web.",
    difficulty: difficult_difficulty
  )

  Answer.create!(
    question: true_false_exp_4,
    text: "Verdadero",
    correct: true
  )

  Answer.create!(
    question: true_false_exp_4,
    text: "Falso",
    correct: false
  )

  true_false_exp_5 = True_False.create!( 
    text: "El algoritmo de BUSQUEDA BINARIA requiere que los elementos estén ordenados previamente.",
    difficulty: difficult_difficulty
  )

  Answer.create!(
    question: true_false_exp_5,
    text: "Verdadero",
    correct: true
  )

  Answer.create!(
    question: true_false_exp_5,
    text: "Falso",
    correct: false
  )

  true_false_exp_6 = True_False.create!( 
    text: "La red social Facebook fue lanzada originalmente para ser utilizada solo por estudiantes universitarios.",
    difficulty: difficult_difficulty
  )

  Answer.create!(
    question: true_false_exp_6,
    text: "Verdadero",
    correct: true
  )

  Answer.create!(
    question: true_false_exp_6,
    text: "Falso",
    correct: false
  )

  true_false_exp_7 = True_False.create!( 
    text: "El lenguaje de programación JAVA es una variante del lenguaje JavaScript.",
    difficulty: difficult_difficulty
  )

  Answer.create!(
    question: true_false_exp_7,
    text: "Verdadero",
    correct: false
  )

  Answer.create!(
    question: true_false_exp_7,
    text: "Falso",
    correct: true
  )

  true_false_exp_8 = True_False.create!( 
    text: "El sistema operativo Mac-OS es desarrollado por Apple Inc.",
    difficulty: difficult_difficulty
  )

  Answer.create!(
    question: true_false_exp_8,
    text: "Verdadero",
    correct: true
  )

  Answer.create!(
    question: true_false_exp_8,
    text: "Falso",
    correct: false
  )

  # Preguntas nivel experto - AUTOCOMPLETADO

  # Pregunta 1
  autocomplete_exp_1 = Autocomplete.create!( 
    text: "El primer sistema operativo de Microsoft se llamaba _ _ _ _ _ _ _ .",
    difficulty: difficult_difficulty
  )

  Answer.create!(
    question: autocomplete_exp_1,
    answers_autocomplete: ["MS-DOS", "ms-dos", "Ms-Dos", "ms-Dos"]
  )

  # Pregunta 2
  autocomplete_exp_2 = Autocomplete.create!( 
    text: "El concepto de 'Internet de las Cosas' se refiere a la interconexión de _ _ _ _ _ _ _ .",
    difficulty: difficult_difficulty
  )

  Answer.create!(
    question: autocomplete_exp_2,
    answers_autocomplete: ["Dispositivos físicos", "dispositivos fisicos", "Dispositivos Físicos", "dispositivos físicos"]
  )

  autocomplete_exp_3 = Autocomplete.create!( 
    text: "El término 'Inteligencia Artificial' fue acuñado por _ _ _ _ _ _ _ en el año 1956.",
    difficulty: difficult_difficulty
  )

  Answer.create!(
    question: autocomplete_exp_3,
    answers_autocomplete: ["John McCarthy", "john mccarthy", "John Mccarthy", "john Mccarthy", "Mccarthy", "mccarthy"]
  )

  autocomplete_exp_4 = Autocomplete.create!( 
    text: "El primer lenguaje de programación de alto nivel fue _ _ _ _ _ _ _ .",
    difficulty: difficult_difficulty
  )

  Answer.create!(
    question: autocomplete_exp_4,
    answers_autocomplete: ["Fortran", "FORTRAN", "fortran"]
  )

  autocomplete_exp_5 = Autocomplete.create!( 
    text: "La arquitectura de computadoras fue propuesta por _ _ _ _ _ _ _ en el año 1945.",
    difficulty: difficult_difficulty
  )

  Answer.create!(
    question: autocomplete_exp_5,
    answers_autocomplete: ["Von Neumann", "von neumann", "Von neumann", "von Neumann", "vonneumann"]
  )

  autocomplete_exp_6 = Autocomplete.create!( 
    text: "El lenguaje de programación ORIENTADO A OBJETOS más utilizado actualmente es _ _ _ _ _ _ _ .",
    difficulty: difficult_difficulty
  )

  Answer.create!(
    question: autocomplete_exp_6,
    answers_autocomplete: ["Java", "JAVA", "java"]
  )

  autocomplete_exp_7 = Autocomplete.create!( 
    text: "El término 'Big Data' se refiere al manejo y análisis de conjuntos de datos extremadamente _ _ _ _ _ _ _ .",
    difficulty: difficult_difficulty
  )

  Answer.create!(
    question: autocomplete_exp_7,
    answers_autocomplete: ["grandes", "Grandes", "GRANDES"]
  )

  autocomplete_exp_8 = Autocomplete.create!( 
    text: "El lenguaje _ _ _ _ _ es el más popular para el desarrollo FRONT-END en aplicaciones web.",
    difficulty: difficult_difficulty
  )

  Answer.create!(
    question: autocomplete_exp_8,
    answers_autocomplete: ["HTML", "html", "Html"]
  )

  autocomplete_exp_9 = Autocomplete.create!( 
    text: "La empresa Microsoft fue fundada por Bill _ _ _ _ _ _ _ y Paul Allen en el año 1975.",
    difficulty: difficult_difficulty
  )

  Answer.create!(
    question: autocomplete_exp_9,
    answers_autocomplete: ["Gates", "gates", "GATES"]
  )

  # Pregunta 3
  autocomplete_exp_10 = Autocomplete.create!( 
    text: "El primer teléfono inteligente con pantalla táctil fue el iPhone, lanzado por _ _ _ _ _ _ _ en el año 2007.",
    difficulty: difficult_difficulty
  )

  Answer.create!(
    question: autocomplete_exp_10,
    answers_autocomplete: ["Apple", "apple", "APPLE"]
  )

end
