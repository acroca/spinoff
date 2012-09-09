class Slot < ActiveRecord::Base
  attr_accessible :day, :program_id, :time

  validates_numericality_of :day, greater_than_or_equal_to: 0
  validates_numericality_of :time, greater_than_or_equal_to: 0, less_than_or_equal_to: 11
  validates_uniqueness_of :time, scope: [:company_id, :day]
  validate :creation_time, on: :create

  belongs_to :company
  belongs_to :program

  def self.tick
    day = ConfigVariables[:day].to_i
    time = ConfigVariables[:time].to_i
    population = ConfigVariables[:population].to_i

    slots = Slot.where(day: day, time: time)
    Audience.distribute(time: time, slots: slots, population: population)

    time += 1
    if time > 11
      time = 0
      day += 1
    end
    ConfigVariables[:day] = day
    ConfigVariables[:time] = time
  end

  private

  def creation_time
    return unless day && time # This is just to prevent nil errors, another
                              # validation will take care of the value.
    return if day > ConfigVariables[:day].to_i
    return if day == ConfigVariables[:day].to_i && time > ConfigVariables[:time].to_i
    errors.add(:time, "Should be a future time")
  end
end
