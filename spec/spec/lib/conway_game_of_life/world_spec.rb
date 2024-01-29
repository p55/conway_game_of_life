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
    let(:world) { described_class.new(width: 2, height: 3) }

    context 'when cell is dead' do
      let(:cell) { world.cell_at(0, 0) }
      before { cell.die! }

      context 'when cell has 1 or 2 living neighbors' do
        it 'does not revive cell' do
          allow(cell).to receive_message_chain(:living_neighbors, :count).and_return(2)
          world.next_iteration!

          next_iteration_cell = world.cell_at(cell.x, cell.y)
          expect(next_iteration_cell.alive?).to eq(false)
        end
      end

      context 'when cell has 3 living neighbors' do
        it 'it makes cell alive' do
          allow(cell).to receive_message_chain(:living_neighbors, :count).and_return(3)
          world.next_iteration!

          next_iteration_cell = world.cell_at(cell.x, cell.y)
          expect(next_iteration_cell.alive?).to eq(true)
        end
      end
    end

    context 'when cell is alive' do
      let(:cell) { world.cell_at(0, 0) }
      before { cell.live! }

      context 'when cell has 2 or 3 live neighbors' do
        it 'does not kill cell' do
          allow(cell).to receive_message_chain(:living_neighbors, :count).and_return(2)
          world.next_iteration!

          next_iteration_cell = world.cell_at(cell.x, cell.y)
          expect(next_iteration_cell.alive?).to eq(true)
        end
      end

      context 'when cell has 1 live neighbor' do
        it 'kills cell' do
          allow(cell).to receive_message_chain(:living_neighbors, :count).and_return(1)
          world.next_iteration!

          next_iteration_cell = world.cell_at(cell.x, cell.y)
          expect(next_iteration_cell.alive?).to eq(false)
        end
      end

      context 'when cell has 4 and more live neighbors' do
        it 'kills cell' do
          allow(cell).to receive_message_chain(:living_neighbors, :count).and_return(4)
          world.next_iteration!

          next_iteration_cell = world.cell_at(cell.x, cell.y)
          expect(next_iteration_cell.alive?).to eq(false)
        end
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
