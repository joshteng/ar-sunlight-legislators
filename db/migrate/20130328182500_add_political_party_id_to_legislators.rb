require_relative '../config'

class AddPoliticalPartyIdToLegislators < ActiveRecord::Migration
  def change
    add_column :legislators, :political_party_id, :integer
  end
end
