require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  before :each do
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end
  describe '#initialize' do
    it 'exists and has attributes' do

      expect(@cell).to be_a(Cell)
      expect(@cell.coordinate).to eq("B4")
      expect(@cell.ship).to be(nil)
    end
  end

  describe '#empty?' do
    it 'checks if the cell is empty' do
      expect(@cell.empty?).to be(true)
    end
  end

  describe '#place_ship' do
    it 'can place a ship instance on a cell' do
      @cell.place_ship(@cruiser)

      expect(@cell.ship).to eq(@cruiser)
      expect(@cell.empty?).to be(false)
    end
  end
end