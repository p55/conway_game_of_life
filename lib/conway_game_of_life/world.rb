# frozen_string_literal: true

module ConwayGameOfLife
  class World
    attr_reader :board, :width, :height

    def initialize(width:, height:)
      @width = width
      @height = height
      @board = Array.new(width) do |x_index|
        Array.new(height) { |y_index| ConwayGameOfLife::Cell.new(x: x_index, y: y_index, world: self) }
      end
    end

    def cells
      @board.flatten
    end

    def print
      system('clear')
      display_array = @board.transpose.map { |row| row.map(&:symbol)  }
      display_array.each { |row| puts row.join(' ') }

      nil
    end

    def cell_at(x, y)
      @board[x][y]
    end

    def next_iteration!
      new_board = Array.new(@width) { Array.new(@height) }

      cells.each do |cell|
        living_neighbors = cell.living_neighbors.count
        new_board[cell.x][cell.y] = ConwayGameOfLife::Cell.new(x: cell.x, y: cell.y, alive: cell.alive?, world: self)

        if cell.dead? && living_neighbors == 3
            new_board[cell.x][cell.y].live!
        elsif living_neighbors < 2 || living_neighbors > 3
            new_board[cell.x][cell.y].die!
        end
      end

      @board = new_board
      true
    end

    def randomize!(living_cells)
      dead_cells = find_dead_cells

      living_cells.times do
        random_dead_cell = dead_cells.sample
        random_dead_cell.live!
        dead_cells.delete(random_dead_cell)
      end

      true
    end

    private

    def find_dead_cells
      cells.find_all(&:dead?)
    end
  end
end
