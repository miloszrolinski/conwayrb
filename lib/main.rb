#!/usr/bin/env ruby

#   Copyright 2015 Miłosz Roliński

#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.

#   This is an implementation of Conway's Game of Life

require_relative './conway.rb'
require 'gtk3'

Gtk.init
# No documentation for now
class ProgramWindow < Gtk::Window
  def initialize(game)
    super()

    self.title = "Conway's game of life"
    set_size_request(300, 300)
    set_resizable(false)

    # Set global image objects for each cell type (alive/dead)
    parent_directory = File.expand_path("..", File.dirname(__FILE__))
    @IMG_CELL_ALIVE = Gdk::Pixbuf.new(file:
                                      parent_directory + '/assets/circle.png')

    @IMG_CELL_DEAD = Gdk::Pixbuf.new(file:
                                     parent_directory + '/assets/cross.png')

    # Save the world ;)
    @game = game

    set_up_gui
    set_up_callbacks

    show_all
  end

  def set_up_gui
    # Keep those to refresh cells during operation
    layout_grid = Gtk::Grid.new

    @cell_grid = get_new_cell_grid
    @cell_alignment = Gtk::Alignment.new(0.5, 0.5, 0, 0)

    x, y = @game.cells.size, @game.cells.size

    @button_next_gen = Gtk::Button.new(label: "Next generation")
    @button_next_gen.expand = true

    # We should center the cell_grid
    @cell_alignment << @cell_grid

    layout_grid.attach(@cell_alignment, 0, 0, x, y)
    layout_grid.attach(@button_next_gen, 0, y, x, 1)

    layout_grid.expand = true
    add(layout_grid)

  end

  def set_up_callbacks
    signal_connect('destroy') { Gtk.main_quit }

    @button_next_gen.signal_connect('clicked') do
      @game.next_generation!
      @cell_grid.destroy
      @cell_grid = get_new_cell_grid
      @cell_grid.show_all
      @cell_alignment << @cell_grid
    end

  end

  def get_new_cell_grid
    new_cell_grid = Gtk::Grid.new
    
    @game.cells.every_cell do |x, y|
      cell_pixbuf = @game.cells.alive?(x, y) ? @IMG_CELL_ALIVE : @IMG_CELL_DEAD
      cell = Gtk::Image.new(pixbuf: cell_pixbuf)
      new_cell_grid.attach(cell, x, y, 1, 1)
    end

     new_cell_grid
  end

end # End of class ProgramWindow

game = Game::new(5)
game.cells.add_life!(8)

program_gui = ProgramWindow.new(game)

Gtk.main
