require './lib/oystercard.rb'

describe Oystercard do
  let(:station) { double(:station) }
  let(:station2) { double(:station2) }

  describe "#initialize" do
    it "the balance should be 0 as default" do
      expect(subject.balance).to eq 0
    end

    it "should have an empty history by default" do
      expect(subject.history).to eq []
    end

  end

  describe "#top_up" do
    it "it increases the balance by 10 when added top through arguement of top_up" do
      expect(subject.top_up(10)).to eq 10
    end

    it "raises an error when top up increases balance over 90 pounds" do
      max_balance = Oystercard::MAX_BALANCE
      subject.top_up(max_balance)
      expect { subject.top_up 1 }.to raise_error ("top up over max balance")
    end
  end

  describe "#touch_in" do
    it "starts a journey when touching in" do
      subject.top_up(10)
      expect(subject).to respond_to(:touch_in)
    end

    context "user touches in twice" do
      it "charges a penalty fare" do
        subject.top_up(10)
        subject.touch_in(station)
        penalty = Journey::PENALTY_FARE
        expect{subject.touch_in(station2)}.to change { subject.balance }.by(-penalty)
      end
    end

    it "raises an error if balance at touch_in < #{Oystercard::MINIMUM_FARE}" do
      expect { subject.touch_in station }.to raise_error ("Please top up before travelling")
    end

  #   it "records entry station" do
  #     subject.top_up 10
  #     subject.touch_in station
  #     expect(subject.entry_station).to eq station
  #   end
   end

  describe "#touch_out" do
    context "user touches out without touching in" do
      it "charges a penalty fare" do
        penalty = Journey::PENALTY_FARE
        expect{subject.touch_out(station2)}.to change { subject.balance }.by(-penalty)
      end
    end

    context "on a journey" do
      before :each do
        subject.top_up(10)
        subject.touch_in(station)
      end

      it "should deduct the minimum fare from the balance" do
        min = Oystercard::MINIMUM_FARE
        expect { subject.touch_out(station2) }.to change { subject.balance }.by(-min)
      end

      # it "should erase the entry station upon touch_out" do
      #   subject.touch_out(station2)
      #   expect(subject.entry_station).to eq nil
      # end

      # it "should add the journey to the history" do
      #   subject.touch_out(station2)
      #   expect(subject.history).to eq [{entry: station , exit: station2}]
      # end

    end

  end

end

#NameError
#./spec/oystercard_spec.rb
#1
#Oystercard class doesn't exist
#creating in the lib folder a file containg the class Oystercard
