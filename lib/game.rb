require_relative './cells.rb'

module Conway
  # Basically a front-end for the Cells class. Encapsulates the functionality
  # in a "black box" of sorts
  class Game
    # Basically a front-end for the Cells class. Encapsulates the functionality
    # in a "black box" of sorts
    attr_accessor :cells
    def initialize(size)
      # No error checking - it's already in Cells.new
      @cells = Cells.new(size)
    end

    public

    def next_generation!
      @cells.proceed!
    end

    def reset!
      @cells = Cells.new(@cells.size)
    end
  end # End of class Game
end
