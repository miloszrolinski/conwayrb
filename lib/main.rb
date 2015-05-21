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

require './conway.rb'
require 'gtk3'

Gtk.init

class ProgramWindow < Gtk::Window
  def initialize(related_world)

    super()

    self.title = "Conway's game of life"
    set_size_request(300, 300)

    # Set global image objects for each cell type (alive/dead)
    @IMG_CELL_ALIVE = Gdk::Pixbuf.new(file: '../assets/circle.png')
    @IMG_CELL_DEAD = Gdk::Pixbuf.new(file: '../assets/cross.png')

    # Save the world ;)
    @world = related_world

    set_up_gui
    set_up_callbacks

    show_all
  end

  def set_up_gui
    # Keep those to refresh cells during operation
    layout_grid = Gtk::Grid.new

    @cell_grid = get_new_cell_grid
    @cell_alignment = Gtk::Alignment.new(0.5, 0.5, 0, 0)

    x, y = @world.width, @world.height

    @button_next_gen = Gtk::Button.new(label: "Next generation")
    @button_next_gen.expand = true

    # We should center the cell_grid
    #refresh_cells!
    @cell_alignment << @cell_grid
    layout_grid.attach(@cell_alignment, 0, 0, x, y)
    layout_grid.attach(@button_next_gen, 0, y, x, 1)

    layout_grid.expand = true
    add(layout_grid)

  end

  def set_up_callbacks
    signal_connect('destroy') { Gtk.main_quit }

    @button_next_gen.signal_connect('clicked') do
      @world.get_next_generation!
      @cell_grid.destroy
      @cell_grid = get_new_cell_grid
      @cell_grid.show_all
      @cell_alignment << @cell_grid
    end

  end

  def get_new_cell_grid
    new_cell_grid = Gtk::Grid.new
    #new_cell_grid.expand = true


    # TODO: Move the stuff below to a function called 'draw_cells!'

    (0...@world.height).each do |y|
      (0...@world.width).each do |x|
        cell_pixbuf = @world.universe[y][x] ? @IMG_CELL_ALIVE : @IMG_CELL_DEAD
        cell = Gtk::Image.new(pixbuf: cell_pixbuf)
        new_cell_grid.attach(cell, x, y, 1, 1)
      end
    end

    return new_cell_grid
  end
end

program_world = World.new(5, 5, 8)

program_gui = ProgramWindow.new(program_world)

Gtk.main
