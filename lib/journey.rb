class Journey

attr_reader :entry, :exit
MINIMUM_FARE = 1
PENALTY_FARE = 6

  def initialize(station = nil)
    @entry = station
    @exit = nil
  end

  def complete?
    !@exit.nil? && !@entry.nil?
  end

  def finish(station)
    @exit = station
  end

  def fare
    return complete? ? MINIMUM_FARE : PENALTY_FARE
  end
end
