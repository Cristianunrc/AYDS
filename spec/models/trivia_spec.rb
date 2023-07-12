require_relative '../../models/init.rb'
require 'sinatra/activerecord'

# Unit testing para modelo Trivia
# Validaciones
describe Trivia do
  describe 'validations' do
    
    it "is invalid without a user ID" do
      trivia = Trivia.new(difficulty_id: 1)
      expect(trivia.valid?).to eq(false)
    end

    it "is invalid without a difficulty ID" do
      trivia = Trivia.new(user_id: 1)
      expect(trivia.valid?).to eq(false)
    end

    it "is valid with all required atributes" do
      trivia = Trivia.new(user_id: 1, difficulty_id: 1)
      expect(trivia.valid?).to eq(true)
    end

  end

  # Asociaciones
  describe 'associations' do
    
    it "has many question_answers" do
      association = described_class.reflect_on_association(:question_answers)
      expect(association.macro).to eq(:has_many)
    end
    
    it "has many questions through question_answers" do
      association = described_class.reflect_on_association(:questions)
      expect(association.macro).to eq(:has_many)
    end

    it "belongs to user" do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it "belongs to difficulty" do
      association = described_class.reflect_on_association(:difficulty)
      expect(association.macro).to eq(:belongs_to)
    end  

  end

end

