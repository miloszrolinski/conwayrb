#   This file is a part of an implementation of Conway's game of life

#   This particular implementation is free software: you can redistribute it
#   and/or modify it under the terms of the GNU General Public License
#   as published by the Free Software Foundation,
#   either version 3 of the License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Game class is for manipulating the cells
# (adding life/calculating neighbors & survival). Cells are represented
# as a 2D array of boolean values (true = alive/ false = dead)
class Game
  attr_reader :width, :height
  attr_accessor :universe

  def initialize(width, height, live_cells)
    @width = width
    @height = height
    @universe = Array.new(@height) { Array.new(@width, false) }
    add_life!(live_cells)
  end

  public

  def add_life!(new_lifes)
    lifes_remaining = new_lifes
    new_universe = @universe

    loop do
      break if lifes_remaining == 0

      x = rand(@width)
      y = rand(@height)

      if @universe[y][x] == true
        next
      else
        new_universe[y][x] = true
        lifes_remaining -= 1
      end
    end

    @universe = new_universe
  end

  private
  def count_live_neighbours(x, y)
    relative_xs = [-1, 0, 1]
    relative_ys = [-1, 0, 1]
    live_neighbours = 0

    if x == 0
      relative_xs.shift
    elsif x == @width - 1
      relative_xs.pop
    end

    if y == 0
      relative_ys.shift
    elsif y == @height - 1
      relative_ys.pop
    end

    relative_ys.each do |relative_y|
      relative_xs.each do |relative_x|
        if @universe[y + relative_y][x + relative_x] == true
          live_neighbours += 1
        end
      end
    end
    live_neighbours -= 1 if @universe[y][x] == true # Account for origin cell

    return live_neighbours
  end

  public

  def total_live_cells
    @universe.map { |row| row.count(true) }.reduce(:+)
  end

  def every_cell(&block)
    (0...@width).each do |y|
      (0...@height).each do |x|
        yield(x, y)
      end
    end
  end


  def get_next_generation!
    new_universe = Array.new(@height) { Array.new(@width, false) }

    (0...@height).each do |y|
      (0...@width).each do |x|
        case count_live_neighbours(x, y)
          when 2
            new_universe[y][x] = @universe[y][x] # Stay alive
          when 3
            new_universe[y][x] = true # Come to life
          else
            new_universe[y][x] = false # Die of loneliness/overcrowding
        end

      end
    end

    @universe = new_universe
  end

  def show #This might get deleted, since we're using a GUI
    (0...@height).each do |y|
      (0...@width).each do |x|

        case @universe[y][x]
        when true
          print "@ "
        when false
          print "+ "
        end

      end
      puts # Separate rows
    end

  end

end # End of class World
