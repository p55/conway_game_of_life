# ConwayGameOfLife

Ruby implementation of the Conway's Game of Life (https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life).


## Usage

Run `bundle console`, then
```
game = ConwayGameOfLife::Game.new(width: 30, height: 20)
game.play(alive_cells: 100, cycles: 50)
```
and watch your life simulation.

You can configure sleep period between next iterations by running

```
ConwayGameOfLife.configure do |config|
  config.sleep_period = 0.5
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/p55/conway_game_of_life.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
