require 'bachet/computer'

describe 'Computer' do
  
  describe 'attribute' do
    before(:example) do
      @computer = Computer.new(3, 'computer')
    end
    
    it 'allows reading for :max_turn_matches' do
      expect(@computer.max_turn_matches).to eq(3)
    end
    
    it 'allows reading and writing for :name' do
      expect(@computer.name).to eq('computer')
    end
  end
  
  describe '#make_move' do
    it 'write a number of a defined range in :taken_matches' do
      computer = Computer.new(3, 'computer')
      expect(computer.make_move(11)).to be_between(1, 3).inclusive
      
      computer = Computer.new(6, 'computer')
      expect(computer.make_move(5)).to be_between(1, 5).inclusive
    end
  end
end
