module Conway
  # 2D array of cells of predetermined size with methods for manipulation
  # and getting stats.
  class Cells
    attr_reader :size

    def initialize(size)
      if size < 0
        fail(ArgumentError, 'Cells.new -> size cannot be negative!')
      elsif !size.is_a?(Fixnum)
        fail(ArgumentError, 'Cells.new -> size has to be numeric!')
      end

      @size = size

      @array = Array.new(size) { Array.new(size, false) }
    end

    def alive?(x, y)
      @array[y][x]
    end

    def add_life!(new_live_cells)
      remaining_cells = new_live_cells

      while remaining_cells > 0
        x = rand(@size)
        y = rand(@size)

        unless alive?(x, y)
          @array[y][x] = true
          remaining_cells -= 1
        end
      end
    end

    def total_lives
      @array.flatten.count(true)
    end

    def live_neighbours(x, y)
      neighbours = Neighbours.all(x, y, @size)
      live_neighbours = 0

      neighbours.each do |rel_x, rel_y|
        live_neighbours += 1 if alive?(x + rel_x, y + rel_y)
      end

      live_neighbours
    end

    def proceed!
      new_array = Array.new(@size) { Array.new(@size, false) }

      every_cell { |x, y| new_array[y][x] = (live_neighbours(x, y) == 3) }
      @array = new_array
    end

    def every_cell
      (0...@size).each do |y|
        (0...@size).each do |x|
          yield(x, y)
        end
      end
    end
  end # End of class Cells

  # This is for managing offsets, so mainly class methods inside
  class Neighbours
    def self.all(x, y, limit)
      neighbours = []
      neighbours.push(*diagonal(x, y, limit))
      neighbours.push(*vertical(y, limit))
      neighbours.push(*horizontal(x, limit))

      neighbours
    end

    def self.horizontal(x, limit)
      x_range = limits(x, limit)
      x_range.size == 2 ? x_range.zip([0, 0]) : [[x_range[0], 0]]
    end

    def self.vertical(y, limit)
      y_range = limits(y, limit)
      y_range.size == 2 ? [0, 0].zip(y_range) : [[0, y_range[0]]]
    end

    def self.diagonal(x, y, limit)
      x_range = horizontal(x, limit)
      y_range = vertical(y, limit)
      diag_range = []

      x_range.each do |x_off, _x|
        y_range.each do |_y, y_off|
          diag_range << [x_off, y_off]
        end
      end

      diag_range
    end

    def self.limits(value, max)
      max_values = []
      max_values << -1 unless value == 0
      max_values << 1 unless value == max - 1

      max_values
    end
  end
end