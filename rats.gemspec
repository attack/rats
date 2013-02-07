# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rats/version'

Gem::Specification.new do |s|
  s.name = %q{rats}
  s.version = Rats::VERSION
  s.authors = ["Mark G"]
  s.email = %q{rats@attackcorp.com}
  s.description = %q{A ruby class to help with using the Alberta Township System}
  s.summary = %q{A ruby class to help with using the Alberta Township System}
  s.homepage = %q{http://github.com/attack/rats}

  s.files = `git ls-files`.split($/)
  s.test_files = s.files.grep(%r{^spec/})
  s.require_paths = ["lib"]

  s.rdoc_options = ["--charset=UTF-8"]
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]

  s.add_development_dependency("rspec")
  s.add_development_dependency("mocha")
  s.add_development_dependency("rake")
  s.add_development_dependency("rdoc")
end

