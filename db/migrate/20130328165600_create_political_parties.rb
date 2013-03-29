require_relative '../config'

# this is where you should use an ActiveRecord migration to 

class CreatePoliticalParties < ActiveRecord::Migration
  def change
    create_table :political_parties do |t|
      t.string :name
      t.timestamps
    end
    # HINT: checkout ActiveRecord::Migration.create_table
    add_index :political_parties, :name
  end

end
