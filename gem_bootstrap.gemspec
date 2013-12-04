# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gem_bootstrap/version'

Gem::Specification.new do |gem|
  gem.name          = 'gem_bootstrap'
  gem.version       = GemBootstrap::VERSION
  gem.authors       = GemBootstrap::AUTHORS
  gem.email         = GemBootstrap::EMAIL
  gem.description   = GemBootstrap::DESCRIPTION
  gem.summary       = GemBootstrap::SUMMARY
  gem.homepage      = GemBootstrap::HOMEPAGE
 
  gem.files = Dir['Rakefile', 'Gemfile', '{bin,lib,man,test,spec}/**/*', 'README*', 'LICENSE*']
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = Dir['{test,spec,features}']

  gem.add_development_dependency 'rspec'
  gem.add_runtime_dependency 'trollop'

end
