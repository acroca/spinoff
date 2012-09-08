class Audience
  config = YAML.load_file(Rails.root.join('config', 'audience.yml'))
  PREFERENCES = config[:audiences_preferences]
  TIMES = config[:times]

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
end
