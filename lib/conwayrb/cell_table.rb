
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
      attr_reader :game
      def initialize(edge_size, initial_live_cells)
        super(edge_size, edge_size)

        @game = Conway::Game.new(edge_size)
        @game.cells.add_life!(initial_live_cells)
        
        parent_directory = File.expand_path('../..', File.dirname(__FILE__))
        @img_alive = Gdk::Pixbuf.new(file:
                                     parent_directory + '/assets/circle.png')

        @img_dead = Gdk::Pixbuf.new(file:
                                    parent_directory + '/assets/cross.png')

        populate! 
      end
   
      def populate!
        @game.cells.every_cell do |x, y|
          cell_pixbuf = @game.cells.alive?(x, y) ? @img_alive : @img_dead

          cell_img = Gtk::Image.new(pixbuf: cell_pixbuf)
          cell_button = Gtk::Button.new()
          cell_button.add(cell_img)
            
          attach(cell_button, x, x + 1, y, y + 1)
        end
        show_all
      end

      def restart_game!(game = nil)
        children.each { |child| child.destroy }

        if game == nil
          @game.reset!
        else
          @game = game
        end

        populate!
      end

      def empty?
        @game.cells.total_lives == 0
      end

    end # ... of class CellTable

  end # ... of module Interface
end # ... of module Conway
