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

class World
  attr_accessor :universe

  public
	def initialize(width, height, live_cells)
    @Width = width
    @Height = height
		@universe = Array.new(@Height) { Array.new(@Width, false) }
    add_life!(live_cells)
	end

  public
  def width
    @Width
  end

  public
  def height
    @Height
  end

  public
	def add_life!(new_lifes)
		lifes_remaining = new_lifes
		new_universe = @universe

		loop do
			if lifes_remaining == 0
				break
			end

			x = rand(@Width)
			y = rand(@Height)

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
    elsif x == @Width - 1
      relative_xs.pop
    end

    if y == 0
      relative_ys.shift
    elsif y == @Height - 1
      relative_ys.pop
    end

    relative_ys.each do |relative_y|
      relative_xs.each do |relative_x|
        if @universe[y + relative_y][x + relative_x] == true
          live_neighbours += 1
        end
      end
    end
    live_neighbours -= 1 if @universe[y][x] == true #account for origin cell

    return live_neighbours
  end

  public
  def get_next_generation!
    new_universe = Array.new(@Height) { Array.new(@Width, false) }

    (0...@Height).each do |y|
      (0...@Width).each do |x|
        new_universe[y][x] = true if count_live_neighbours(x, y) == 3
      end
    end

    @universe = new_universe
  end

  public
  def show #This might get deleted, since we're using a GUI
    (0...@Height).each do |y|
      (0...@Width).each do |x|

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
