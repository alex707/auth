# rake db:seed

require_relative '../../config/environment' # comment when `rake db:migrate`

namespace :db do
  desc 'Run seeds'
  task :seed, %i[version] => :settings do |t, args|
    require 'sequel'
    require 'sequel/extensions/seed'

    Sequel.extension :seed
    Sequel::Seed.setup(:development)

    Sequel.connect(Settings.db.to_hash) do |db|
      version = args.version.to_i if args.version
      seeds = File.expand_path('../../db/seeds', __dir__)

      Sequel::Seeder.apply(db, seeds, target: version)
    end
  end
end
