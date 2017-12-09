# -*- encoding: utf-8 -*-
require File.expand_path('../lib/twdeps/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nicholas E. Rabenau"]
  gem.email         = ["nerab@gmx.net"]
  gem.description   = %q{Takes a TaskWarrior export and emits a graph that visualizes the dependencies between tasks.}
  gem.summary       = %q{Visualizes dependencies between TaskWarrior tasks.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "twdeps"
  gem.require_paths = ["lib"]
  gem.version       = TaskWarrior::Dependencies::VERSION

  gem.add_dependency 'ruby-graphviz', '~> 1.0.7'
  gem.add_dependency 'trollop', '~> 1'
  gem.add_dependency 'taskwarrior', '~> 0.0.6'
  gem.add_development_dependency 'twtest', '~> 0.0.6'
  gem.add_development_dependency 'guard-test', '~> 0.5'
  gem.add_development_dependency 'guard-bundler', '~> 2.1'
  gem.add_development_dependency 'rake', '~> 12.3'
end
