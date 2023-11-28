# frozen_string_literal: true

RSpec.describe ConwayGameOfLife::Cell do
  describe '#symbol' do
    context 'when cell is alive' do
      it "returns #{described_class::ALIVE_SYMBOL}" do
        cell = described_class.new(x: 0, y: 0, world: nil, alive: true)
        expect(cell.symbol).to eq(described_class::ALIVE_SYMBOL)
      end
    end

    context 'when cell is dead' do
      it "returns #{described_class::DEAD_SYMBOL}" do
        cell = described_class.new(x: 0, y: 0, world: nil, alive: false)
        expect(cell.symbol).to eq(described_class::DEAD_SYMBOL)
      end
    end
  end

  describe '#live!' do
    context 'when cell is dead' do
      it 'makes cell alive' do
        cell = described_class.new(x: 0, y: 0, world: nil, alive: false)
        expect { cell.live! }.to(change { cell.alive? }.from(false).to(true))
      end
    end

    context 'when cell is alive' do
      it 'keeps cell alive' do
        cell = described_class.new(x: 0, y: 0, world: nil, alive: true)
        expect { cell.live! }.to_not(change { cell.alive? })
      end
    end
  end

  describe '#die!' do
    context 'when cell is alive' do
      it 'makes cell dead' do
        cell = described_class.new(x: 0, y: 0, world: nil, alive: true)
        expect { cell.die! }.to(change { cell.alive? }.from(true).to(false))
      end
    end

    context 'when cell is dead' do
      it 'keeps cell dead' do
        cell = described_class.new(x: 0, y: 0, world: nil, alive: false)
        expect { cell.die! }.to_not(change { cell.alive? })
      end
    end
  end

  describe '#alive?' do
    context 'when cell is alive' do
      it 'retunrs true' do
        cell = described_class.new(x: 0, y: 0, world: nil, alive: true)
        expect(cell.alive?).to be(true)
      end
    end

    context 'when cell is dead' do
      it 'returns false' do
        cell = described_class.new(x: 0, y: 0, world: nil, alive: false)
        expect(cell.alive?).to be(false)
      end
    end
  end

  describe '#dead?' do
    context 'when cell is alive?' do
      it 'returns false' do
        cell = described_class.new(x: 0, y: 0, world: nil, alive: true)
        expect(cell.dead?).to be(false)
      end
    end

    context 'when cell is dead?' do
      it 'returns true' do
        cell = described_class.new(x: 0, y: 0, world: nil, alive: false)
        expect(cell.dead?).to be(true)
      end
    end
  end

  describe '#neighbors' do
    let(:world) { ConwayGameOfLife::World.new(width: 3, height: 3) }

    context 'cell is top left' do
      it 'returns cells from inside the board only' do
        cell = world.cell_at(0, 0)

        expect(cell.neighbors).to eq(
          [
            world.cell_at(1, 0),
            world.cell_at(1, 1),
            world.cell_at(0, 1),
          ]
        )
      end
    end

    context 'cell is on top border' do
      it 'returns cells from inside the board only' do
        cell = world.cell_at(1, 0)

        expect(cell.neighbors).to eq(
          [
            world.cell_at(2, 0),
            world.cell_at(2, 1),
            world.cell_at(1, 1),
            world.cell_at(0, 1),
            world.cell_at(0, 0)
          ]
        )
      end
    end

    context 'cell is top right' do
      it 'returns cells from inside the board only' do
        cell = world.cell_at(2, 0)

        expect(cell.neighbors).to eq(
          [
            world.cell_at(2, 1),
            world.cell_at(1, 1),
            world.cell_at(1, 0)
          ]
        )
      end
    end

    context 'cell is on rigth border' do
      it 'returns cells from inside the board only' do
        cell = world.cell_at(2, 1)

        expect(cell.neighbors).to eq(
          [
            world.cell_at(1, 0),
            world.cell_at(2, 0),
            world.cell_at(2, 2),
            world.cell_at(1, 2),
            world.cell_at(1, 1)
          ]
        )
      end
    end

    context 'cell is bottom right' do
      it 'returns cells from inside the board only' do
        cell = world.cell_at(2, 2)

        expect(cell.neighbors).to eq(
          [
            world.cell_at(1, 1),
            world.cell_at(2, 1),
            world.cell_at(1, 2)
          ]
        )
      end
    end

    context 'cell is on bottom border' do
      it 'returns cells from inside the board only' do
        cell = world.cell_at(1, 2)

        expect(cell.neighbors).to eq(
          [
            world.cell_at(0, 1),
            world.cell_at(1, 1),
            world.cell_at(2, 1),
            world.cell_at(2, 2),
            world.cell_at(0, 2)
          ]
        )
      end
    end

    context 'cell is bottom left' do
      it 'returns cells from inside the board only' do
        cell = world.cell_at(0, 2)

        expect(cell.neighbors).to eq(
          [
            world.cell_at(0, 1),
            world.cell_at(1, 1),
            world.cell_at(1, 2)
          ]
        )
      end
    end

    context 'cell is on left border' do
      it 'returns cells from inside the board only' do
        cell = world.cell_at(0, 1)

        expect(cell.neighbors).to eq(
          [
            world.cell_at(0, 0),
            world.cell_at(1, 0),
            world.cell_at(1, 1),
            world.cell_at(1, 2),
            world.cell_at(0, 2)
          ]
        )
      end
    end

    context 'cell is inside border' do
      it 'returns all neighbor cells' do
        cell = world.cell_at(1, 1)

        expect(cell.neighbors).to eq(
          [
            world.cell_at(0, 0),
            world.cell_at(1, 0),
            world.cell_at(2, 0),
            world.cell_at(2, 1),
            world.cell_at(2, 2),
            world.cell_at(1, 2),
            world.cell_at(0, 2),
            world.cell_at(0, 1)
          ]
        )
      end
    end
  end

  describe '#living_neighbors' do
    it 'returns only living neighbors' do
      neighbor_one = double(:cell, alive?: true)
      neighbor_two = double(:cell, alive?: true)
      neighbor_three = double(:cell, alive?: false)
      cell = described_class.new(x: nil, y: nil, world: nil)

      expect(cell).to receive(:neighbors).and_return([neighbor_one, neighbor_two, neighbor_three])
      expect(cell.living_neighbors).to eq([neighbor_one, neighbor_two])
    end
  end
end
