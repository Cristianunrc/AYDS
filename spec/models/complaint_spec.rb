require_relative '../../models/init.rb'
require 'sinatra/activerecord'

describe Complaint do
  describe 'validations' do
    
    it "is invalid without a description" do
      complaint = Complaint.new(user_id: 1)
      expect(complaint.valid?).to eq(false)
    end

    it "is invalid without a user ID" do
      complaint = Complaint.new(description: "description text")
      expect(complaint.valid?).to eq(false)
    end

    it "is valid with all required atributes" do
      complaint = Complaint.new(description: "description text", user_id: 1)
      expect(complaint.valid?).to eq(true)
    end

  end

  describe 'associations' do
  
    it "belongs to user" do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end
    
  end
  
end