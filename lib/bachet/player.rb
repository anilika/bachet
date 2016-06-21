class Player
  attr_reader :max_turn_matches, :name
  
  def initialize(max_turn_matches, name)
    @name = name
    @max_turn_matches = max_turn_matches
  end
  
  def make_move(matches)
    loop do
      begin
        taken_matches = Integer(gets.chomp)
        return taken_matches if correct?(taken_matches, matches)
        puts puts "Not so far)"
      rescue ArgumentError
        puts 'invalid value'
      end
    end
  end
  
  def correct?(taken_matches, matches)
  (1..max_turn_matches).include?(taken_matches) && (1..matches).include?(taken_matches)
  end
end
