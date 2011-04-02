# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "foghub/version"

Gem::Specification.new do |s|
  s.name        = "foghub"
  s.version     = Foghub::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Simon Hørup Eskildsen"]
  s.email       = ["se@firmafon.dk"]
  s.homepage    = ""
  s.summary     = %q{Foghub associates Git commits with Fogbugz cases and code reviews}
  s.description = %q{Foghub associates Git commits with Fogbugz cases and code reviews}

  s.rubyforge_project = "foghub"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
