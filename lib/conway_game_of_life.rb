# frozen_string_literal: true

require_relative 'conway_game_of_life/version'
require_relative 'conway_game_of_life/config'
require_relative 'conway_game_of_life/cell'
require_relative 'conway_game_of_life/world'
require_relative 'conway_game_of_life/game'

module ConwayGameOfLife
  class Error < StandardError; end
end
