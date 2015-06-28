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

  # Encapsulates the 'Cells' class to expose as little details as necessary
  class Game
    attr_accessor :cells
    def initialize(size)
      # No error checking - it's already in Cells.new
      @cells = Cells.new(size)
    end

    public

    def next_generation!
      @cells.proceed!
    end

    def reset!
      @cells = Conway::Cells.new(@cells.size)
    end
  end # ... of class Game
end
