# TaskWarrior Dependency Visualization

Visualizes dependencies between TaskWarrior tasks.

## Installation

    $ gem install twdeps

## Usage

  # Create a dependency graph as PNG and pipe it to a file
  task export rc.json.array=on rc.verbose=nothing | twdeps > deps.png
  
  # Same but override format. Use the file option to specify the file name to write to
  task export rc.json.array=on rc.verbose=nothing | twdeps --format svg --file deps.svg
  
  # Create a graph from a previously exported file
  cat tasks.json | twdeps > deps.png

## Limitations

TaskWarrior 2.0 needs the command line options `rc.json.array=on` and `rc.verbose=nothing` due to [two](http://taskwarrior.org/issues/1017) [bugs](http://taskwarrior.org/issues/1013) in JSON export.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
