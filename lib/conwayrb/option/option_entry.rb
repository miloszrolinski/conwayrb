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
    class OptionEntry < Option
      def initialize(name, with_random, desc)

        @option_value = Gtk::Entry.new
        @option_value.max_length = 2
        @option_value.width_chars = 3

        super(name, with_random, desc)
      end

      def value
        if @toggle.active?
          rand(7) + 3
        else
          @option_value.text.to_i
        end
      end

      def value=(property_value)
        @option_value.text = property_value.to_s
      end

    end # ... of class Option

  end # ... of module Interface
end # ... of module Conway
