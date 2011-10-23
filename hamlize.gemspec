# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "hamlize/version"

Gem::Specification.new do |s|
  s.name        = "hamlize"
  s.version     = Hamlize::VERSION
  s.authors     = ["Matte Noble"]
  s.email       = ["me@mattenoble.com"]
  s.homepage    = ""
  s.summary     = %q{Convert a directory of HAML into HTML.}
  s.description = %q{Convert a directory of HAML into HTML.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.executables   = ["hamlize"]

  s.add_development_dependency "rspec", "~> 2.7.0"
  s.add_dependency "haml"
  s.add_dependency "guard-haml"
  s.add_dependency "rb-fsevent"
  s.add_dependency "rb-inotify"
  s.add_dependency "rb-fchange"
end
