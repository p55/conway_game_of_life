# frozen_string_literal: true

require_relative "lib/conway_game_of_life/version"

Gem::Specification.new do |spec|
  spec.name = "conway_game_of_life"
  spec.version = ConwayGameOfLife::VERSION
  spec.authors = ['Przemyslaw Kedzierski']
  spec.email = ['kedzierski.przemyslaw@gmail.com']

  spec.summary = "Conway's Game of Life according to https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life"
  spec.description = "Simple Conway's Game of Life Ruby implementation"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", "~> 3.2"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
