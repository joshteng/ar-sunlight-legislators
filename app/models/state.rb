require_relative '../../db/config'

class State < ActiveRecord::Base
  attr_accessible :name

  has_many :legislators

end
