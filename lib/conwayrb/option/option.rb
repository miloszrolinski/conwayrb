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
      def initialize(name, with_random, desc)
        super(:horizontal)
        label = Gtk::Label.new(name)
        label.width_chars = 15
        self.homogeneous = false

        self.spacing = 5

        pack_start(label, expand: false)
        pack_start(@option_value, expand: true)

        unit = Gtk::Label.new(desc)
        unit.width_chars = 8
        pack_start(unit, expand: false)

        @toggle = Gtk::CheckButton.new('Random')

        @toggle.sensitive = false if not with_random

        pack_start(@toggle, expand: false)

      end

      def value
        raise NameError, "This is an abstract function. Override, don't call."
      end

      def value=(property_value)
        raise NameError, "This is an abstract function. Override, don't call."
      end

    end # ... of class Option

  end # ... of module Interface
end # ... of module Conway
