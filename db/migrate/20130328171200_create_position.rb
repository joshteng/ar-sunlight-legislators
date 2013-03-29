require_relative '../config'

class CreatePosition < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :name
      t.timestamps
    end
    add_index :positions, :name
  end
end
