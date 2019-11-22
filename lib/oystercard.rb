require_relative 'station'
require_relative 'journey'

class Oystercard

  attr_reader :balance, :history, :in_journey
  MAX_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize(journey_class = Journey)
    @balance = 0
    @history = []
    @journey_class = journey_class
    @journey = nil
  end

  def top_up(value)
    fail "top up over max balance" if @balance + value > MAX_BALANCE
    @balance += value
  end

  def touch_in (entry_station)
    deduct(@journey.fare) unless @journey.nil?
    fail "Please top up before travelling" if @balance < MINIMUM_FARE
    #@history.unshift({ entry: station })
    @journey = @journey_class.new
    @journey.start(entry_station)
  end

  def touch_out(exit_station)
    @journey = @journey_class.new if @journey.nil?
    @journey.finish(exit_station)
    deduct(@journey.fare)
      #@history[0][:exit] = exit_station
    @history << @journey if @journey.complete?
    @journey = nil
  end

  # def entry_station
  #   @history[0][:entry] if in_journey?
  # end

  private
  # attr_reader :in_journey
  def deduct(fare)
    @balance -= fare
  end

  # def in_journey?
  #   return false if @history.empty?
  #   !@history[0][:entry].nil? && @history[0][:exit].nil?
  # end

end
