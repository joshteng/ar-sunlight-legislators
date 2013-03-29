require 'csv'
require 'rake'
require 'rspec/core/rake_task'
require_relative 'app/models/state'
require_relative 'app/models/political_party'
require_relative 'app/models/position'
require_relative 'app/models/legislator'
require_relative 'db/config'
require_relative 'lib/query'

$file = "db/data/legislators.csv"

task :console do
  exec "irb -r./app.rb"
end


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
    positions = ['Representative', 'Senator']
    positions.each do |p|
      Position.create(name: p)
    end
  end

  task :legislators do
    Legislator.delete_all
    csv = CSV.new(File.open($file), headers: true)
    csv.each do |row|
      legislator = row.to_hash
      legislator['phone_number'].gsub!(/\D*/, "") unless legislator[:phone_number].nil?
      legislator['fax'].gsub!(/\D*/, "") unless legislator[:fax].nil?
      legislator['in_office'] = legislator[:in_office] == "1" ? true : false
      legislator_object = Legislator.create(legislator)


      #create association with party
      if legislator["party"] == 'D'
        democrat = PoliticalParty.where('name = ?', 'D').first
        democrat.legislators<< legislator_object
      elsif legislator[:party] == 'R'
        republican = PoliticalParty.where('name = ?', 'R').first
        republican.legislators<< legislator_object
      else
        independent = PoliticalParty.where('name = ?', 'I').first
        independent.legislators<< legislator_object
      end

      #create association with position
      if legislator["title"] == 'Rep'
        position = Position.find_by_name('Representative')
        position.legislators << legislator_object
      elsif legislator["title"] == 'Sen'
        position = Position.find_by_name('Senator')
        position.legislators<< legislator_object
      end


      #create association with state
      state = State.find_by_name(legislator["state"])
      state.legislators<< legislator_object
      # puts row.to_hash
      # 3 associations to take care: political_party, position, state

    end
  end
end

namespace :query do
  task :senators do
    Query::senator
  end
end


# Given any state, first print out the senators for that state 
# (sorted by last name), then print out the representatives 
# (also sorted by last name). Include the party affiliation next to the name. 
# The output might look something like this:


