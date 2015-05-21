require_relative '../lib/conway.rb'

describe World do
  describe new do
    it 'returns an instance with given number of live cells' do
      live_cells = 8
      world = World.new(3, 3, live_cells)
      expect(world.universe.map {|row| row.count(true)}.inject(:+)).to eql live_cells
    end

  end

end
