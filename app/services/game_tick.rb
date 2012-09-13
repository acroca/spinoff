class GameTick
  def self.perform
    day = ConfigVariables[:day].to_i
    time = ConfigVariables[:time].to_i
    population = ConfigVariables[:population].to_i

    slots = Slot.where(day: day, time: time)
    Audience.distribute(time: time, slots: slots, population: population)
    slots.each(&:pay!)

    time += 1
    if time > 11
      time = 0
      day += 1
    end

    ConfigVariables[:day] = day
    ConfigVariables[:time] = time
    Pusher["spinoff"].trigger("game-tick", {day: day, time: time})
  end
end
