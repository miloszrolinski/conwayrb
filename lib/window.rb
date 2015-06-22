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
        
        set_size_request(300, 400) 
        self.resizable = false
        
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
        @main_vbox.spacing = 5
        @cell_table = Conway::Interface::CellTable.new(@edge_size,
                                                       @default_live_cells)

        @controls = Conway::Interface::Controls.new
        @controls.disable([:stop])

        @main_vbox.pack_start(@cell_table)
        @main_vbox.pack_start(@controls, expand: false)

        status_bar = Gtk::Statusbar.new
        context = status_bar.get_context_id('Values')
        status_bar.push(context, 
                        "Edge size: #{@edge_size}\t"+
                        "Initial live cells: #{@default_live_cells}\t"+
                        "Refresh speed: #{@refresh_speed} generations/sec")

        @main_vbox.pack_start(status_bar, expand: false)

        add(@main_vbox)
      end

      def set_callbacks
        signal_connect('destroy') do
          Gtk.main_quit
        end

        @controls.access[:next_gen].signal_connect('clicked') do
           update_cell_table!
           @controls.disable([:next_gen, :loop, :stop]) if @cell_table.empty?
        end

        @controls.access[:loop].signal_connect('clicked') do
          @controls.disable([:loop, :reset, :next_gen])
          @controls.enable([:stop])
          @loop_id = GLib::Timeout.add((1000/@refresh_speed).floor) do
                      update_cell_table!

                      @cell_table.game.cells.total_lives > 0 
                      if @cell_table.empty?
                        @controls.disable([:next_gen, :loop, :stop])
                        @controls.enable([:reset])
                        false
                      else
                        true
                      end
                    end
        end

        @controls.access[:stop].signal_connect('clicked') do
          GLib::Source.remove(@loop_id)
          @controls.enable([:reset])
          @controls.enable([:next_gen, :loop]) unless @cell_table.empty?
      
          @controls.disable([:stop])
        end

        @controls.access[:reset].signal_connect('clicked') do
          @cell_table.destroy
          @cell_table = Conway::Interface::CellTable.new(@edge_size,
                                                         @default_live_cells)

          @controls.enable([:next_gen, :loop, :reset, :stop])
          @controls.disable([:stop])

          @main_vbox.pack_start(@cell_table)
          @main_vbox.reorder_child(@cell_table, Gtk::PackType::START)
        end
      end

      def update_cell_table!
        @cell_table.game.next_generation!
        game = @cell_table.game

        @cell_table.destroy
        @cell_table = Conway::Interface::CellTable.new(@edge_size,
                                                       @default_live_cells)
        @cell_table.restart_game!(game)
        @main_vbox.pack_start(@cell_table)
        @main_vbox.reorder_child(@cell_table, Gtk::PackType::START)
      end

    end # ... of class MainWindow

  end # ... of module Interface
end # ... of module Conway
