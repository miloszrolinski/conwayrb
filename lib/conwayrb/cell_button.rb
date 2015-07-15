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
    class Cell < Gtk::Button
      def initialize(is_alive)
        super()

        parent_directory = File.expand_path('../..', File.dirname(__FILE__))
        @img_alive = Gdk::Pixbuf.new(file:
                                     parent_directory + '/assets/circle.png')

        @img_dead = Gdk::Pixbuf.new(file:
                                    parent_directory + '/assets/cross.png')

        @is_alive = is_alive
        
        @status_image = nil
        assign_status
        
        add(@status_image)
      end

      def assign_status
        @status_image = Gtk::Image.new(pixbuf: @is_alive ? @img_alive : 
                                                           @img_dead)
      end
        
      def update(new_state)
        @status_image.destroy
        @is_alive = @is_alive ? false : true
        assign_status
        add(@status_image)
        @status_image.show
      end
        
    end # ... of class Cell
  end # ... of module Interface
end # ... of module Conway
