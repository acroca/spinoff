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

  describe ".distribute_audience" do
    let(:programs) { [create(:movie, popularity: 11, genre: Genre::GENRES.first),
                      create(:movie, popularity: 19, genre: Genre::GENRES.first),
                      create(:movie, popularity: 1, genre: Genre::GENRES.second)] }
    let(:time) { 0 }
    let(:slots) { programs.map{|p| create(:slot, program: p, company_id: p.company_id, time: time) } }

    it "distributes the audience" do
      Audience.distribute(population: 10000, time: time, slots: slots)
      slots.first.reload.audience.should  == (10000 * Audience.ratio(time, Genre::GENRES.first) * (11/30.0)).to_i
      slots.second.reload.audience.should == (10000 * Audience.ratio(time, Genre::GENRES.first) * (19/30.0)).to_i
      slots.third.reload.audience.should  == (10000 * Audience.ratio(time, Genre::GENRES.second)).to_i
    end
  end
end
