class Answer < ActiveRecord::Base
  belongs_to :question, polymorphic: true
  has_many :question_answers
  has_many :questions, through: :question_answers
  serialize :answers_autocomplete, JSON # indicacion a active record para que reconozca la columna como arreglo
  validates :question_id, presence: true 
end
