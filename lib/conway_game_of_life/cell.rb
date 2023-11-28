# frozen_string_literal: true

module ConwayGameOfLife
  class Cell
    ALIVE_SYMBOL = '■'
    DEAD_SYMBOL = '▢'

    attr_reader :x, :y, :alive

    def initialize(x:, y:, world:, alive: false)
      @x = x
      @y = y
      @world = world
      @alive = alive
    end

    def symbol
      @alive ? ALIVE_SYMBOL : DEAD_SYMBOL
    end

    def live!
      @alive = true
    end

    def die!
      @alive = false
    end

    def alive?
      @alive == true
    end

    def dead?
      !@alive
    end

    def neighbors
      neighbor_indexes.map do |cell_index|
        @world.cell_at(cell_index[0], cell_index[1])
      end
    end

    def living_neighbors
      neighbors.select(&:alive?)
    end

    private

    def neighbor_indexes
      top_left = [x - 1, y - 1]
      top = [x, y - 1]
      top_right = [x + 1, y - 1]
      right = [x + 1, y]
      bottom_right = [x + 1, y + 1]
      bottom = [x, y + 1]
      botom_left = [x - 1, y + 1]
      left = [x - 1, y]

      [top_left, top, top_right, right, bottom_right, bottom, botom_left, left].reject do |pair|
        pair[0].negative? ||
          pair[0] >= @world.width ||
          pair[1].negative? ||
          pair[1] >= @world.height
      end
    end
  end
end
