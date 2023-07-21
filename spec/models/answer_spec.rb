require_relative '../../models/init.rb'
require 'sinatra/activerecord'

describe Answer do
  # Solo se hicieron validaciones para question_id
  describe 'validations' do

    it "is invalid without a question ID in answer for choice question" do
      answer = Answer.new(text: "choice text", correct: false)
    end

    it "is invalid without a question ID in answer for true-false question" do
      answer = Answer.new(text: "true-false text", correct: false)
    end

    it "is invalid without a question ID in answer for autocomplete question" do
      answer = Answer.new(answers_autocomplete: ["elem 1", "elem 2", "elem n"])
    end

  end

  describe 'associations' do

    it "belongs to question" do
      association = described_class.reflect_on_association(:question)
      expect(association.macro).to eq(:belongs_to)
    end

    it "has many question_answers" do
      association = described_class.reflect_on_association(:question_answers)
      expect(association.macro).to eq(:has_many)
    end

    it "has many questions through question_answers" do
      association = described_class.reflect_on_association(:questions)
      expect(association.macro).to eq(:has_many)
    end

  end

end
