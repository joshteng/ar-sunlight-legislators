require 'csv'
require 'rake'
require 'rspec/core/rake_task'
require_relative 'app/models/state'
require_relative 'app/models/political_party'
require_relative 'db/config'


desc "create the database"
task "db:create" do
  touch 'db/ar-sunlight-legislators.sqlite3'
end

desc "drop the database"
task "db:drop" do
  rm_f 'db/ar-sunlight-legislators.sqlite3'
end

desc "migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog)."
task "db:migrate" do
  ActiveRecord::Migrator.migrations_paths << File.dirname(__FILE__) + 'db/migrate'
  ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
  ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths, ENV["VERSION"] ? ENV["VERSION"].to_i : nil) do |migration|
    ENV["SCOPE"].blank? || (ENV["SCOPE"] == migration.scope)
  end
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end

desc "Run the specs"
RSpec::Core::RakeTask.new(:specs)

task :default  => :specs


namespace :import do
  task :states do
    csv = CSV.read("db/data/legislators.csv")
    csv.shift
    states = csv.map { |x| x[7] }
    states.uniq!
    states.each do |state|
      State.create(name: state)
    end
  end

  task :political_party do
    csv = CSV.read("db/data/legislators.csv")
    csv.shift
    parties = csv.map { |x| x[6] }
    parties.uniq!
    parties.each do |party|
      PoliticalParty.create(name: party)
    end
  end

  task :position do
    

  end
end
