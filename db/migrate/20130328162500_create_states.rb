require_relative '../config'

# this is where you should use an ActiveRecord migration to 

class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name
      t.timestamps
    end
    # HINT: checkout ActiveRecord::Migration.create_table
    add_index :states, :name
  end

end
