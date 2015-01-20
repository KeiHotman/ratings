namespace :db do
  desc "extended db:seed"
  namespace :seed do
    task syllabus: :environment do
      seed_file = File.join(Rails.root, 'db', 'seeds', 'syllabus.rb')
      load(seed_file)
    end

    task previous: :environment do
      seed_file = File.join(Rails.root, 'db', 'seeds', 'previous_experiment.rb')
      load(seed_file)
    end
  end
end
