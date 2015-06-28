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

    # Controls class holds the buttons. It does not contain the callbacks 
    # (handled in 'MainWindow'), just the layout and a way to manipulate the 
    # buttons (access the objects, disable/enable the buttons).
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

      def set_sensitivity(ids, value)
        ids.each do |id|
          access[id].set_sensitive(value)
        end
      end

      def disable(ids)
        set_sensitivity(ids, false)
      end

      def enable(ids)
        set_sensitivity(ids, true)
      end

    end # ... of class Controls

  end # ... of module Interface
end # ... of module Conway
