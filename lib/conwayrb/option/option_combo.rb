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
    class OptionCombo < Option
      def initialize(name, desc, opts)
        @option_value = Gtk::ComboBoxText.new
        @fields = opts

        @fields.each do |field|
          @option_value.append_text(field.to_s)
        end

        @option_value.active = 0

        super(name, false, desc)
      end

      def value
        @fields[@option_value.active]
      end

      def value=(property_value)
        @option_value.active = property_value.to_i
      end

    end # ... of class Option

  end # ... of module Interface
end # ... of module Conway
