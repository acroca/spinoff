class Audience
  config = YAML.load_file(Rails.root.join('config', 'audience.yml'))
  PREFERENCES = config['audiences_preferences']
  TIMES = config['times']

  GENRES_BY_TIME = TIMES.inject({}) do |acc, (time, ratios)|
    genres = Hash.new(0)
    ratios.each do |population, ratio|
      PREFERENCES[population].map do |genre, preference|
        genres[genre] += preference * ratio
      end
    end
    acc[time] = genres
    acc
  end

  def self.ratio(time, genre)
    Audience::GENRES_BY_TIME[time][genre]
  end

  def self.distribute(options)
    time   = options[:time]
    population = options[:population]

    slots_by_genre = options[:slots].group_by{ |slot| slot.program.genre }

    slots_by_genre.each do |genre, slots|
      total_popularity = slots.map { |slot| slot.program.popularity }.sum.to_f
      slots.each do |slot|
        slot.audience = (population * ratio(time, genre) * (slot.program.popularity/total_popularity))
        slot.save
      end
    end
  end
end
