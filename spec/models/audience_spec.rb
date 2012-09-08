require 'spec_helper'

describe Audience do
  Audience::PREFERENCES.each do |population, preference|
    it "contains valid audience preferences on #{population}" do
      preference.values.sum.should be_between(0.9998, 1.001)
    end

    it "contains valid genres in audience preferences on #{population}" do
      (preference.keys - Genre::GENRES).should be_empty
    end
  end

  Audience::TIMES.each do |time, ratios|
    it "contains valid times ratio for #{time}" do
      ratios.values.sum.should be_between(0.9998, 1.001)
    end
  end

  Audience::GENRES_BY_TIME.each do |time, genres|
    it "contains valid genres by time for #{time}" do
      genres.values.sum.should be_between(0.9998, 1.001)
    end
  end
end
