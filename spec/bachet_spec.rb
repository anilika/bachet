require 'bachet'

describe 'Bachet' do
  before do
    class Options
      attr_reader :m, :n, :p
      def initialize
        @m = 3
        @n = 15
        @p = false
      end
    end
    @options = Options.new
  end
  describe 'attributes' do
    before(:example) do
      @game = Bachet.new(@options)
    end
    
    context 'when used default options' do
      it 'allows reading for :matches' do
        expect(@game.matches).to eq(15)
      end
      describe ':options' do
        it 'allows reading for :options' do
          expect(@game.options).to be_an(Options)
        end
        
        it 'respond to :m' do
          expect(@game.options).to respond_to(:m)
        end
        it 'respond to :n' do
          expect(@game.options).to respond_to(:n)
        end
        it 'respond to :p' do
          expect(@game.options).to respond_to(:p)
        end
      end
    end
  end
  
  describe '#create_players' do
    it 'return players array' do
      game = Bachet.new(@options)
      expect(game.create_players).to be_an(Array)
    end
  end
  
  describe '#player_turn' do
    before do
      @game = Bachet.new(@options)
      @players = @game.create_players
      io_obj = double
      expect(@players[0]).to receive(:gets).and_return(io_obj)
      expect(io_obj).to receive(:chomp).and_return('2')
    end
    
    it 'puts a string with players name who turn' do
      expect{@game.player_turn(@players[0])}.to output("turn player1\n").to_stdout
    end
    
    it 'reduces matches for number of player turn' do
      @game.player_turn(@players[0])
      expect(@game.matches).to eq(13)
    end
  end
  
  describe '#compute_turn' do
    before do
      @game = Bachet.new(@options)
      @players = @game.create_players
    end
    
    it 'puts a string with computers name and number of computers turn' do
      expect{@game.computer_turn(@players[1])}
      .to output(/turn computer is : /).to_stdout
    end
    
    it 'reduces matches for number of computer turn' do
      @game.computer_turn(@players[1])
      expect(@game.matches).to be_between(12, 14).inclusive
    end
  end
    
  describe '#win' do
    it 'puts on the screen a string with name of win' do
      game = Bachet.new(@options)
      players = game.create_players
      expect { game.win(players[0]) }. to output("Player1 win!\n").to_stdout
      expect { game.win(players[1]) }. to output("Computer win!\n").to_stdout
    end
  end
  
  describe '#display_matches' do
    it 'outputs a string with matches to stdout' do
      game = Bachet.new(@options)
      expect { game.display_matches }
      .to output("| | | | | | | | | | | | | | |  -- 15\n").to_stdout
    end
  end
  
  describe '#welcome' do
    it 'output a string with greetings to stdout' do
      game = Bachet.new(@options)
      expect { game.welcome }.to output("Welcome to the Bachet Game\n").to_stdout
    end
  end
  
  describe '#change_matches' do
    it 'takes away matches' do
      game = Bachet.new(@options)
      expect { game.change_matches(3) }.to change(game, :matches).from(15).to(12)
    end
  end
end