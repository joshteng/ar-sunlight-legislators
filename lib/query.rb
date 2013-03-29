module Query
  def self.senator(state)
    state = State.find_by_name(state)
    state.legislators
  end

end
