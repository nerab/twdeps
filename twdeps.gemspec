# -*- encoding: utf-8 -*-
require File.expand_path('../lib/twdeps/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nicholas E. Rabenau"]
  gem.email         = ["nerab@gmx.net"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "twdeps"
  gem.require_paths = ["lib"]
  gem.version       = TaskWarrior::Dependencies::VERSION
  
  gem.add_dependency 'ruby-graphviz', '~> 1.0'
  gem.add_development_dependency 'twtest'
end
