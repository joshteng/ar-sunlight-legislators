require_relative '../../db/config'

class PoliticalParty < ActiveRecord::Base
  attr_accessible :name

end
