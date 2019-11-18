require './lib/oystercard.rb'

describe Oystercard do

  describe "#initialize" do
    it "the balance should be 0 as default" do
      expect(subject.balance).to eq 0
    end
  end
  describe "#top_up" do
    it "it increases the balance by 10 when added top through arguement of top_up" do
      expect(subject.top_up(10)).to eq 10
    end
  end
end

#NameError
#./spec/oystercard_spec.rb
#1
#Oystercard class doesn't exist
#creating in the lib folder a file containg the class Oystercard
