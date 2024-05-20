# frozen_string_literal: true

RSpec.describe ConwayGameOfLife::Game do
  describe '#play' do
    it 'plays the game' do
      world = instance_double(ConwayGameOfLife::World)
      width = 10
      height = 10
      alive_cells = 20
      cycles = 2
      config = double(:config, sleep_period: 0)

      expect(ConwayGameOfLife::World).to receive(:new)
        .with(width: width, height: height)
        .and_return(world)
      game = described_class.new(width: width, height: height)

      expect(world).to receive(:randomize!).with(alive_cells)
      expect(world).to receive(:print)
        .exactly(cycles).times
      expect(world).to receive(:next_iteration!)
        .exactly(cycles).times
      expect(ConwayGameOfLife).to receive(:config)
        .exactly(cycles).times.and_return(config)
      expect(game).to receive(:sleep).with(config.sleep_period)
        .exactly(cycles).times

      game.play(alive_cells: alive_cells, cycles: cycles)
    end
  end
end
