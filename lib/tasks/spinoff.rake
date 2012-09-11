namespace :spinoff do
  desc "Performs a game tick"
  task :tick => :environment do
    GameTick.perform
  end
end
