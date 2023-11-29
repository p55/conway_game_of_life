# frozen_string_literal: true

RSpec.describe ConwayGameOfLife::World do
  describe '#cells' do
    it 'returns flattened array of cells' do
      world = described_class.new(width: 2, height: 3)

      expect(world.cells).to eq(world.board.flatten)
    end
  end

  describe '#cell_at' do
    it 'returns cell at given x and y indexes' do
      world = described_class.new(width: 2, height: 3)

      expect(world.cell_at(0, 0)).to eq(world.board[0][0])
      expect(world.cell_at(1, 2)).to eq(world.board[1][2])
    end
  end

  describe '#next_iteration!' do
    context 'when cell is dead' do
      context 'when cell has 1 or 2 living neighbors' do
        pending 'does not revive cell'
      end

      context 'when cell is dead and have exactly 3 living neighbors' do
        pending 'it makes cell alive'
      end
    end

    context 'when cell is alive' do
      context 'when cell has 2 or 3 live neighbors' do
        pending 'does not kill cell'
      end

      context 'when cell has 1 live neighbor' do
        pending 'kills cell'
      end

      context 'when cell has 4 and more live neighbors' do
        pending 'kills cell'
      end
    end
  end

  describe '#randomize' do
    it 'randomly makes given number of cells alive' do
      world = described_class.new(width: 5, height: 5)

      dead_cells = world.cells.find_all(&:dead?)
      expect(dead_cells.count).to eq(25)

      world.randomize!(5)
      dead_cells = world.cells.find_all(&:dead?)
      expect(dead_cells.count).to eq(20)
    end
  end
end
