
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
  module Interface

    # CellTable is the graphical representation of the 'Cells' object
    # Holds the images for each type of cell (dead/alive), returns an
    # item that can be placed in a GTK window for showing.
    class CellTable < Gtk::Table
      attr_reader :cells
      def initialize(edge_size, initial_live_cells, img_size)
        super(edge_size, edge_size)

        @cells = Conway::Cells.new(edge_size)
        @cells.add_life!(initial_live_cells)
        @starting_lives = initial_live_cells
        @img_size = img_size

        populate!
      end

      def populate!
        @cells.every_cell do |x, y|
          cell_button = Conway::Interface::CellButton.new(@cells.alive?(x, y), @img_size)

          cell_button.signal_connect('clicked') do
            @cells.toggle(x, y)
            cell_button.update(@cells.alive?(x, y))
          end

          attach(cell_button, x, x + 1, y, y + 1)
        end
        show_all
      end

      def restart_game!(game = nil)
        children.each { |child| child.destroy }
        if game == nil
          size = @cells.size
          @cells = Conway::Cells.new(size)
          @cells.add_life!(@starting_lives)
        else
          @cells = game
        end

        populate!
      end

      def empty?
        @cells.total_lives == 0
      end

    end # ... of class CellTable

  end # ... of module Interface
end # ... of module Conway
