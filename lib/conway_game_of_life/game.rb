# frozen_string_literal: true

module ConwayGameOfLife
  class Game
    def initialize(width:, height:)
      @world = ConwayGameOfLife::World.new(width: width, height: height)
    end

    def play(alive_cells:, cycles:)
      @world.randomize!(alive_cells)

      cycles.times do
        @world.print
        @world.next_iteration!
        sleep(ConwayGameOfLife.config.sleep_period)
      end
    end
  end

  class << self
    def config
      @config ||= ConwayGameOfLife::Config.new
    end

    def configure
      yield(config) if block_given?
    end
  end
end
