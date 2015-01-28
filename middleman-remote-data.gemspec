# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "middleman-remote-data"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Scotty Nelson"]
  s.email       = ["me@scotty.is"]
  s.homepage    = "http://scotty.is"
  s.summary     = %q{A short summary of your extension}
  # s.description = %q{A longer description of your extension}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # The version of middleman-core your extension depends on
  s.add_runtime_dependency("middleman-core", [">= 3.3.7"])

  # Additional dependencies
  s.add_runtime_dependency("faraday", ">= 0.9.1")
  s.add_runtime_dependency("faraday_middleware", ">= 0.9.1")
  s.add_runtime_dependency("faraday-http-cache", ">= 1.0.0")
  s.add_runtime_dependency("multi_xml", ">= 0.5.5")
end
