# frozen_string_literal: true

module ConwayGameOfLife
  class Config
    attr_accessor :sleep_period

    def initialize
      @sleep_period = 0.25
    end
  end
end
