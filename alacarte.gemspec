# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "alacarte/version"

Gem::Specification.new do |s|
  s.name        = "alacarte"
  s.version     = Alacarte::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Stijn Mathysen"]
  s.email       = ["stijn@skylight.be"]
  s.homepage    = "http://github.com/stijnster/alacarte"
  s.summary     = %q{Provides a generic menu system for Rails}
  s.description = %q{This Rails plugin allows you to create a menu system, using a dsl (similar to routes).}

  s.rubyforge_project = "alacarte"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
