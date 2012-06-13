# -*- encoding: utf-8 -*-
$:.unshift File.expand_path("../lib", __FILE__)
require "finder/version"

Gem::Specification.new do |gem|
  gem.name          = "finder"
  gem.authors       = ["zak"]
  gem.email         = ["zak.31337@gmail.com"]
  gem.description   = ""
  gem.summary       = ""
  gem.homepage      = "http://github.com/zak/finder"

  gem.files         = Dir.glob('{bin,lib}/**/*') #`git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "finder"
  gem.require_path  = "lib"
  gem.version       = Finder::VERSION

  gem.add_dependency "httparty", "~> 0.8"

  gem.add_development_dependency "rspec-core", "~> 2.10"
  gem.add_development_dependency "rspec-mocks", "~> 2.10"
  gem.add_development_dependency "rspec-expectations", "~> 2.10"
end
