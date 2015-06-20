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

    class MainWindow < Gtk::Window
      def initialize(edge_size = 4, initial_live_cells = 9, refresh_speed = 1)
        super('Conway\'s game of life')

        set_size_request(300, 300) 
        set_resizable(false)
        
        @edge_size = edge_size
        @default_live_cells = initial_live_cells
        @refresh_speed = refresh_speed
        @loop_id = nil
        
        set_layout
        set_callbacks  

        show_all
      end

      def set_layout
        @main_vbox = Gtk::Box.new(:vertical)
        @cell_table = CellTable.new(@edge_size, @default_live_cells)

        @controls = Controls.new

        @main_vbox.pack_start(@cell_table)
        @main_vbox.pack_start(@controls)

        add(@main_vbox)
      end

      def set_callbacks
        signal_connect('destroy') do
          Gtk.main_quit
        end

        @controls.access[:next_gen].signal_connect('clicked') do
           update_cell_table!
        end

        @controls.access[:loop].signal_connect('clicked') do
          @loop_id = GLib::Timeout.add_seconds(@refresh_speed) do
                      update_cell_table!

                      @cell_table.game.cells.total_lives > 0 
                    end
        end

        @controls.access[:stop].signal_connect('clicked') do
          GLib::Source.remove(@loop_id)
        end

        @controls.access[:reset].signal_connect('clicked') do
          @cell_table.destroy
          @cell_table = CellTable.new(@edge_size, @default_live_cells)

          @main_vbox.pack_start(@cell_table)
          @main_vbox.reorder_child(@cell_table, Gtk::PackType::START)
        end
      end

      def update_cell_table!
        @cell_table.game.next_generation!
        game = @cell_table.game

        @cell_table.destroy
        @cell_table = CellTable.new(@edge_size, @default_live_cells)
        @cell_table.restart_game!(game)
        @main_vbox.pack_start(@cell_table)
        @main_vbox.reorder_child(@cell_table, Gtk::PackType::START)
      end

    end # ... of class MainWindow

    class CellTable < Gtk::Table
      attr_reader :game
      def initialize(edge_size, initial_live_cells)
        super(edge_size, edge_size)

        @game = Conway::Game.new(edge_size)
        @game.cells.add_life!(initial_live_cells)
        
        parent_directory = File.expand_path('..', File.dirname(__FILE__))
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
          attach(cell_img, x, x + 1, y, y + 1)
        end
        show_all
      end

      def restart_game!(game)
        children.each { |child| child.destroy }

        @game = game
        populate!
      end

    end # ... of class CellTable

    class Controls < Gtk::Box
      attr_reader :buttons
      alias :access :buttons

      def initialize
        super(:vertical)

        @buttons = {}

        pack_start(create_control('Next generation', :next_gen))
        @loop_ctrls_hbox = Gtk::Box.new(:horizontal)
        @loop_ctrls_hbox.pack_start(create_control('Run in loop', :loop))
        @loop_ctrls_hbox.pack_start(create_control('Stop', :stop))
        @loop_ctrls_hbox.pack_start(create_control('Reset', :reset))
        pack_start(@loop_ctrls_hbox)

      end
      
      def create_control(label, symbol)
        button = Gtk::Button.new(label: label)
        @buttons[symbol] = button

        button
      end

    end # ... of class Controls

  end # ... of module Interface
end # ... of module Conway
