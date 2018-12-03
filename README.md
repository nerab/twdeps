# TaskWarrior Dependency Visualization

Visualizes dependencies between TaskWarrior tasks.

[![Build Status](https://secure.travis-ci.org/nerab/twdeps.png?branch=master)](http://travis-ci.org/nerab/twdeps)
[![Gem Version](https://badge.fury.io/rb/twdeps.png)](http://badge.fury.io/rb/twdeps)

## Example

Given a set of interdependent tasks, they are

1. Exported from TaskWarrior as JSON, then
1. Piped into `twdeps`, and finally
1. The output is directed to a PNG file.

Result:

![party](https://raw.github.com/nerab/twdeps/master/examples/party.png)

For the impatient: The JSON export is also available as [party.json](https://raw.github.com/nerab/twdeps/master/test/fixtures/party.json). Once you installed `twdeps`, the command

```bash
$ curl https://raw.githubusercontent.com/nerab/twdeps/master/test/fixtures/party.json | twdeps -f png > party.png
```

will generate `party.png` in the current directory. If you don't want to download the JSON file, try the local oen that comes with `twdeps`:

```bash
$ twdeps $(dirname $(gem which twdeps))/../test/fixtures/party.json -f png > party.png
```

## Installation

```bash
$ gem install twdeps
```

## Usage

* Create a dependency graph as PNG and pipe it to a file:

  ```bash
  task export | twdeps > deps.png
  ```

  See [Limitations](Limitations) below for why we need the extra task parms

* Same but specify output format

  ```bash
  task export | twdeps --format svg > deps.svg
  ```

  * Create a graph from a previously exported file

  ```bash
  task export > tasks.json
  cat tasks.json | twdeps > deps.png
  ```

* Display graph in browser without creating an intermediate file

  ```bash
  task export | twdeps --format svg | bcat
  ```

  [bcat](http://rtomayko.github.com/bcat/) is required for piping into a browser.

## Dependencies

The graph is generated with [ruby-graphviz](https://github.com/glejeune/Ruby-Graphviz), which in turn requires a local [Graphviz](http://graphviz.org/) installation (e.g. `brew install graphviz` on a Mac or `sudo apt-get install graphviz` on Ubuntu Linux).


[bundler](http://bundler.io/) is also required.

## Limitations

TaskWarrior versions before 2.1 need the additional command line options `rc.json.array=on` and `rc.verbose=nothing` due to [two](http://taskwarrior.org/issues/1017) [bugs](http://taskwarrior.org/issues/1013) in the JSON export.
