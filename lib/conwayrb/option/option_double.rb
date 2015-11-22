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
    class OptionDouble < Option
      def initialize(name, with_random, desc)

        @option_value = Gtk::Box.new(:horizontal)
        first_entry, second_entry = Gtk::Entry.new, Gtk::Entry.new
        first_entry.max_length = 2
        second_entry.max_length = 2

        first_entry.width_chars = 4
        second_entry.width_chars = 4

        @option_value.pack_start(first_entry)
        @option_value.pack_start(second_entry)

        super(name, with_random, desc)
      end

      def value
        if @toggle.active?
          rand(7) + 3
        else
          output = Array.new
          @option_value.children.each do |entry|
            output << entry.text.to_i
          end
          return output
        end
      end

      def value=(property_value)
        @option_value.children.each do |entry|
          entry.text = property_value.to_s
        end
      end

    end # ... of class Option

  end # ... of module Interface
end # ... of module Conway
