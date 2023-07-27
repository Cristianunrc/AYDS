require_relative '../../models/init.rb'
require 'sinatra/activerecord'

describe Question do

  describe 'validations' do
    
    it "is invalid without a text" do
      beginner_difficulty = Difficulty.new(level: :beginner)
      question = Question.new(difficulty_id: beginner_difficulty)
      expect(question.valid?).to eq(false)
    end

    it "is invalid without a difficulty ID" do
      beginner_difficulty = Difficulty.new(level: :beginner)
      question = Question.new(text: "question text?")
      expect(question.valid?).to eq(false)
    end

  end

  describe 'associations' do
    
    it "has many question_answers" do
      association = described_class.reflect_on_association(:question_answers)
      expect(association.macro).to eq(:has_many)
    end

    it "has many answers through question_answers" do
      association = described_class.reflect_on_association(:answers)
      expect(association.macro).to eq(:has_many)
    end

    it "belongs to difficulty" do
      association = described_class.reflect_on_association(:difficulty)
      expect(association.macro).to eq(:belongs_to)
    end

  end
  
end