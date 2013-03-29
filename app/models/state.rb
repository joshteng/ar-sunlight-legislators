require_relative '../../db/config'

class State < ActiveRecord::Base
  attr_accessible :name

end
