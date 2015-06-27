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
        @main_vbox = Gtk::Box.new(:vertical)

        @option_edge_size = Conway::Interface::Option.new('Edge size')
        @option_edge_size.value = edge_size_default
        @option_initial_lives = Conway::Interface::Option.new('Initial lives')
        @option_initial_lives.value = initial_lives_default
        @option_refresh_speed = Conway::Interface::Option.new('Refresh speed',
                                                              false, 'gen/sec')
        @option_refresh_speed.value = refresh_speed_default

        @main_vbox.pack_start(@option_edge_size)
        @main_vbox.pack_start(@option_initial_lives)
        @main_vbox.pack_start(@option_refresh_speed)

        @button_save = Gtk::Button.new(label: 'Save')
        @main_vbox.add(@button_save)
        
        add(@main_vbox)
        signal_connect('delete_event') do
          Gtk.main_quit
        end

        @button_save.signal_connect('clicked') do
          produce_main_window!
          self.destroy
        end
        show_all
      end
        

      def produce_main_window!
        Conway::Interface::MainWindow.new(@option_edge_size.value,
                                          @option_initial_lives.value,
                                          @option_refresh_speed.value )
      end
        
    end # ... of class Settings

    class Option < Gtk::Box
      def initialize(name, with_random = true, desc = nil)
        super(:horizontal)
        label = Gtk::Label.new(name)
        label.width_chars = 15
        self.homogeneous = false

        @entry = Gtk::Entry.new
        @entry.max_length = 2
        @entry.width_chars = 3

        pack_start(label)
        pack_start(@entry, expand: false)

        if with_random
          @toggle = Gtk::CheckButton.new('Random')
        else
          @toggle = Gtk::CheckButton.new(desc)
          @toggle.sensitive = false
        end
          pack_start(@toggle)

      end

      def value?
        if @toggle.active?
          rand(7) + 3
        else
          @entry.text.to_i
        end
      end

      def value=(property_value)
        @entry.text = property_value.to_s
      end

    end # ... of class Option

  end # ... of module Interface
end # ... of module Conway
