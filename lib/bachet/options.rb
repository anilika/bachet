require 'optparse'

class Options
  attr_reader :n, :m, :p, :options, :option_parse
  DEFOULT_OPTS = {all_matches: 15, max_turn_matches: 3}
  
  def initialize
    @options = {}
    parse_args
    setting_options = {}
    setting_options[:n] = options[:all_matches]
    setting_options[:m] = options[:max_turn_matches]
    setting_options[:p] = options[:player]
    setting_options
  end
  
  def parse_args
    @option_parse = OptionParser.new do |opts|
        options[:all_matches] = 15
        opts.on('-n', '--all_matches ALL_MATCHES', 'Starts matches should be in range of 8 to 40') do |matches|
          options[:all_matches] = Integer(matches)
        end
        options[:max_turn_matches] = 3
        opts.on('-m', '--max_turn_matches MAX_TURN_MATCHES', 'Max matches per turn should be in range of 2 to n/2') do |max_matches|
          options[:max_turn_matches] = Integer(max_matches)
        end
        options[:player] = false
        opts.on('-p', '--player', 'Play with another player') do
          options[:player] = true
        end
        opts.on('-h', '--help', 'Prints this help') do
          puts opts
          exit
        end
      end
    begin
      option_parse.parse!
      unless options_valid?(options[:all_matches], options[:max_turn_matches])
        puts 'invalid options'
        puts '8 <= n < 40'
        puts '2 <= m < n/2'
        print option_parse
        exit
      end
    rescue OptionParser::InvalidOption, OptionParser::MissingArgument, ArgumentError => e
      warn e.to_s.capitalize
      puts option_parse
      exit
    end
  end
  
  def options_valid?(n, m)
    (8...40).include?(n) && (2...n/2).include?(m) ? true : false
  end
  
  def show_hepl
    puts option_parse
  end
end