require './lib/ship'

RSpec.describe Ship do
  before :each do
    @cruiser = Ship.new("Cruiser", 3)
  end
  describe '#initialize' do
    it 'exists and has attributes' do      
      expect(@cruiser).to be_a(Ship)
      expect(@cruiser.name).to eq("Cruiser")
      expect(@cruiser.length).to eq(3)
    end
    
  end
  describe '#health' do
    it 'has health equal to its length' do
      expect(@cruiser.health).to eq(3)
    end 
  end

  describe '#sunk?' do
    it 'starts not sunk' do
      expect(@cruiser.sunk?).to be(false)
    end

    it 'is sunk when health is zero' do
      3.times { @cruiser.hit }
      expect(@cruiser.health).to eq(0)
      expect(@cruiser.sunk?).to be(true)
    end
  end

  describe '#hit' do
    it 'can be hit and reduce health by 1' do
      @cruiser.hit

      expect(@cruiser.health).to eq(2)
    end

    it 'will not reduce health below 0' do
      3.times { @cruiser.hit }

      expect(@cruiser.health).to eq(0)

      @cruiser.hit

      expect(@cruiser.health).to eq(0)
    end
  end
end