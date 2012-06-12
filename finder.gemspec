# -*- encoding: utf-8 -*-
require File.expand_path('../lib/finder/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["zak"]
  gem.email         = ["zak.31337@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = "http://github.com/zak/finder"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "finder"
  gem.require_paths = ["lib"]
  gem.version       = Finder::VERSION

  gem.add_development_dependency "rspec-core", "~> 2.10"
end
