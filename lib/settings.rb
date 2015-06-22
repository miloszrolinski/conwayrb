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
  
    class Settings < Gtk::Window
      def initialize(edge_size_default = 3, initial_lives_default = 5,
                     refresh_speed_default = 1)
        super('Settings')
        
        self.resizable = false
        set_size_request(300, 150)
        @main_table = Gtk::Table.new(6, 4)

        @label_edge_size = Gtk::Label.new('Edge size')
        @label_initial_lives = Gtk::Label.new('Initial lives')
        @label_refresh_speed = Gtk::Label.new('Refresh speed')

        @main_table.attach(@label_edge_size, 0, 3, 0, 1)
        @main_table.attach(@label_initial_lives, 0, 3, 1, 2)
        @main_table.attach(@label_refresh_speed, 0, 3, 2, 3)

        @entry_edge_size = Gtk::Entry.new
        @entry_edge_size.text = edge_size_default.to_s
        @entry_initial_lives = Gtk::Entry.new
        @entry_initial_lives.text = initial_lives_default.to_s
        @entry_refresh_speed = Gtk::Entry.new
        @entry_refresh_speed.text = refresh_speed_default.to_s

        @entry_edge_size.width_chars = 2
        @entry_initial_lives.width_chars = 2
        @entry_refresh_speed.width_chars = 2

        @main_table.attach(@entry_edge_size, 4, 5, 0, 1)
        @main_table.attach(@entry_initial_lives, 4, 5, 1, 2)
        @main_table.attach(@entry_refresh_speed, 4, 5, 2, 3)

        @toggle_random_edge_size = Gtk::CheckButton.new('Random')
        @toggle_random_initial_lives = Gtk::CheckButton.new('Random')

        @main_table.attach(@toggle_random_edge_size, 5, 6, 0, 1)
        @main_table.attach(@toggle_random_initial_lives, 5, 6, 1, 2)

        @button_save = Gtk::Button.new(label: 'Save')
        @main_table.attach(@button_save, 0, 6, 3, 4)

        
        add(@main_table)
        signal_connect('delete_event') do
          produce_main_window!
          self.destroy
        end

        @button_save.signal_connect('clicked') do
          produce_main_window!
          self.destroy
        end
        show_all
      end
        

      def produce_main_window!
        edge_size = @toggle_random_edge_size.active? ? rand(7) + 3 : 
                                               @entry_edge_size.text.to_i

        initial_lives = @toggle_random_initial_lives.active? ? rand(7) + 3 : 
                                               @entry_initial_lives.text.to_i

        Conway::Interface::MainWindow.new(edge_size,
                                          initial_lives,
                                          @entry_refresh_speed.text.to_i )
      end
        
    end # ... of class Settings

  end # ... of module Interface
end # ... of module Conway
