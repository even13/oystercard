require 'journey'

describe Journey do
  let(:station1) { double :entry_station }
  let(:station2) { double :exit_station }
  subject(:journey) { Journey.new(station1) }

  context "a journey has been started but not completed" do

    it "should not be complete" do
      expect(journey).to_not be_complete
    end

    it "should know the point of entry" do
      expect(journey.entry).to eq station1
    end

    context "a journey has been started and completed" do
      before do
        journey.finish(station2)
      end
      it "should be complete" do
        expect(journey).to be_complete
      end
      it "should know the point of exit" do
        expect(journey.exit).to eq station2
      end
    end
  end

  describe "#fare" do

    it "should return minimum fare if journey is complete" do
      journey.finish(station2)
      expect(journey.fare).to eq Journey::MINIMUM_FARE
    end

    it "journey hasn't been completed" do
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end

    it "touchout but no touch in before" do
      journey = Journey.new
      journey.finish(station2)
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end
  end

end
