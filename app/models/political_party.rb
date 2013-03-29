require_relative '../../db/config'

class PoliticalParty < ActiveRecord::Base
  attr_accessible :name

  has_many :legislators

end
