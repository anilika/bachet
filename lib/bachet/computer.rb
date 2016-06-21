class Computer
  attr_reader :max_turn_matches, :name
  
  def initialize(max_turn_matches, name)
    @name = name
    @max_turn_matches = max_turn_matches
  end
  
  def make_move(matches)
    turn = matches % (max_turn_matches + 1)
    turn == 0 ? 1 : turn
  end
end
