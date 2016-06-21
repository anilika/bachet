require 'bachet/computer'
require 'bachet/player'
require 'bachet/options'

class Bachet
  attr_reader :options, :matches

  def initialize(options)
    @options = options
    @matches = options.n
  end

  def start
    players = create_players
    welcome
    display_matches
    loop do
      players.each do |player|
        player.is_a?(Computer) ? computer_turn(player) : player_turn(player)
        return win(player) if matches == 0
        display_matches
      end
    end
  end

  def player_turn(player)
    puts "turn #{player.name}"
    change_matches(player.make_move(matches))
  end

  def computer_turn(computer)
    taken_matches = computer.make_move(matches)
    puts "turn #{computer.name} is : #{taken_matches}"
    change_matches(taken_matches)
  end

  def display_matches
    puts '| ' * matches + " -- #{matches}\n"
  end

  def welcome
    puts "Welcome to the Bachet Game\n"
  end

  def change_matches(taken_matches)
    @matches -= taken_matches
  end

  def create_players
    players = []
    players << Player.new(options.m, 'player1')
    if options.p
      players << Player.new(options.m, 'player2')
    else
      players << Computer.new(options.m, 'computer')
    end
    players
  end

  def win(player)
    puts "#{player.name.capitalize} win!"
  end
end
