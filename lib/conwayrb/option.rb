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
    
    # A horizontal box that holds a single line of initial settings.
    # Includes a name of the property, input box and a checkbox to allow
    # for random values. The last one can be disabled and replaced with a 
    # longer description of the input value (to explain the units for example).
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

      def value
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
