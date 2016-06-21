require 'bachet/player'

describe 'Player' do
  before(:example) do
    @player = Player.new(3, 'player1')
  end
  
  describe 'attributes' do
    it'allows reading for :max_turn_matches' do
      expect(@player.max_turn_matches).to eq(3)
    end
    
    it 'allow reading for :name' do
      expect(@player.name).to eq('player1')
    end
  end
  
  describe '#correct?' do
    context 'when corrected turn' do
      it 'retutn true' do
        expect(@player).to be_correct(3, 7)
      end
    end

    context 'when uncorrected turn' do
      it 'return false' do
        expect(@player.correct?(5, 7)).to be_falsey
        expect(@player.correct?(3, 2)).to be_falsey
      end
    end
  end
  
  describe '#make_move' do
    it 'return number entering player' do
      io_obj = double
      expect(@player).to receive(:gets).and_return(io_obj).twice
      expect(io_obj).to receive(:chomp).and_return('4')
      expect(io_obj).to receive(:chomp).and_return('2')
      expect(@player.make_move(7)).to eq(2)
    end
  end
end
