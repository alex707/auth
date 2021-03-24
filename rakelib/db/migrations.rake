# RACK_ENV=development rake db:migrate

namespace :db do
  desc 'Run database migrations'
  task :migrate, %i[version] => :settings do |t, args|
    require 'sequel/core'
    Sequel.extension :schema_dumper
    Sequel.extension :migration

    Sequel.connect(Settings.db.to_hash) do |db|
      migrations = File.expand_path('../../db/migrations', __dir__)
      version = args.version.to_i if args.version

      Sequel::Migrator.run(db, migrations, target: version)

      db.extension :schema_dumper

      value = "# version: #{db[:schema_migrations].all.last[:filename].match(/^\d{14}/)[0]}\n\n"
      schema = db.dump_schema_migration.gsub(/^\s+$/, '')

      File.write('db/schema.rb', value + schema, mode: 'w')
    end
  end
end
