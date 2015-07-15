#    This file is part of conwayrb.
#
#    conwayrb is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    conwayrb is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with conwayrb.  If not, see <http://www.gnu.org/licenses/>.

module Conway

  # Cells class holds the implementation details of the game.
  # The constructor creates an empty(!) square table holding the cells,
  # each being either alive or dead. 
  # Manages counting the live neighbours or total cells alive as well as
  # re-populating the table based on whether the cells should stay alive, come 
  # to life or die.
  # Contains convenience methods for checking cell's status and looping through 
  # the whole table and running a lambda over each cell.
  class Cells
    attr_reader :size

    def initialize(size)
      if size < 0
        fail(ArgumentError, 'Cells.new -> size cannot be negative!')
      elsif !size.is_a?(Fixnum)
        fail(ArgumentError, 'Cells.new -> size has to be numeric!')
      end

      @size = size

      @array = Array.new(size) { Array.new(size, false) }
    end
    
    def alive?(x, y)
      @array[y][x]
    end

    def toggle(x, y)
      @array[y][x] = self.alive?(x, y) ? false : true
    end

    def add_life!(new_live_cells)
      if new_live_cells + self.total_lives > size**2
        raise(ArgumentError, 'Cannot add that many lives')
      end
      remaining_cells = new_live_cells

      while remaining_cells > 0
        x = rand(@size)
        y = rand(@size)

        unless alive?(x, y)
          @array[y][x] = true
          remaining_cells -= 1
        end
      end
    end

    def total_lives
      @array.flatten.count(true)
    end

    def live_neighbours(x, y)
      neighbours = Neighbours.all(x, y, @size)
      live_neighbours = 0

      neighbours.each do |rel_x, rel_y|
        live_neighbours += 1 if alive?(x + rel_x, y + rel_y)
      end

      live_neighbours
    end

    def proceed!
      new_array = Array.new(@size) { Array.new(@size, false) }

      every_cell do |x, y| 
        if alive?(x, y)
          new_array[y][x] = (2..3).include? live_neighbours(x, y)
        else
          new_array[y][x] = (live_neighbours(x, y) == 3)
        end
      end

      @array = new_array
    end
    
    # Accepts a block, which can use the |x, y| coordinates of the cell
    def every_cell
      (0...@size).each do |y|
        (0...@size).each do |x|
          yield(x, y) if block_given?
        end
      end
    end
  end # ... of class Cells

  # Neighbours class manages providing the (relative) coordinates of a cell's
  # neighbours. 
  class Neighbours
    def self.all(x, y, limit)
      neighbours = []
      neighbours.push(*diagonal(x, y, limit))
      neighbours.push(*vertical(y, limit))
      neighbours.push(*horizontal(x, limit))

      neighbours
    end

    def self.horizontal(x, limit)
      x_range = limits(x, limit)
      x_range.size == 2 ? x_range.zip([0, 0]) : [[x_range[0], 0]]
    end

    def self.vertical(y, limit)
      y_range = limits(y, limit)
      y_range.size == 2 ? [0, 0].zip(y_range) : [[0, y_range[0]]]
    end

    def self.diagonal(x, y, limit)
      x_range = horizontal(x, limit)
      y_range = vertical(y, limit)
      diag_range = []

      x_range.each do |x_off, _x|
        y_range.each do |_y, y_off|
          diag_range << [x_off, y_off]
        end
      end

      diag_range
    end

    def self.limits(value, max)
      max_values = []
      max_values << -1 unless value == 0
      max_values << 1 unless value == max - 1

      max_values
    end
  end # ... of class Neighbours
end # ... of module Conway
