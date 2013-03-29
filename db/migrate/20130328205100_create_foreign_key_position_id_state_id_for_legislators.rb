require_relative '../config'

class CreateForeignKeyPositionIdStateIdForLegislators < ActiveRecord::Migration
  def change
    add_column :legislators, :state_id, :integer
    add_column :legislators, :position_id, :integer
    add_index :legislators, :position_id
    add_index :legislators, :state_id
    add_index :legislators, :political_party_id
  end
end
