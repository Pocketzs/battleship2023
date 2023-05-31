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
  
  describe 'fired_upon?' do
    it 'checks if the cell has been fired upon' do
      expect(@cell.fired_upon?).to be(false)
    end
  end
  
  describe '#fire_upon' do
    it 'can set a cell to be fired upon and reduce a ship health by 1 if present' do
      @cell.place_ship(@cruiser)
      
      @cell.fire_upon
      
      expect(@cell.ship.health).to eq(2)
      expect(@cell.fired_upon?).to be(true)
    end
    
    it 'does not reduce ship health more than once per cell' do
      @cell.place_ship(@cruiser)
      
      @cell.fire_upon
      @cell.fire_upon
      
      expect(@cell.ship.health).to eq(2)
    end

    it 'sets fired upon to be true if no ship is present' do
      @cell.fire_upon
      
      expect(@cell.fired_upon?).to be(true)
    end
  end

  describe '#render' do
    it 'shows a . if the cell has not been fired upon' do
      expect(@cell.render).to eq(".")
    end
    
    it 'shows M if the cell has been fired upon and miss' do
      @cell.fire_upon

      expect(@cell.render).to eq("M")
    end
    
    it 'shows H if fired upon and hit' do
      @cell.place_ship(@cruiser)
      @cell.fire_upon

      expect(@cell.render).to eq("H")
    end
    
    it 'shows X if fired upon and ship sunk' do
      @cell.place_ship(@cruiser)
      @cell.fire_upon
      2.times {@cruiser.hit}
      expect(@cruiser.sunk?).to be(true)
  
      expect(@cell.render).to eq("X")
    end

    it 'shows S if reveal is turned on and ship is present' do
      expect(@cell.render(true)).to eq(".")
      @cell.place_ship(@cruiser)
      expect(@cell.render(true)).to eq("S")
    end
  end
end