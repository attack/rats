# coding: utf-8
$:.push File.expand_path('../lib', __FILE__)
require 'rats/version'

Gem::Specification.new do |s|
  s.name = 'rats'
  s.version = Rats::VERSION
  s.authors = ['Mark Gangl']
  s.email = ['mark@attackcorp.com']
  s.description = 'A ruby class to help with using the Alberta Township System'
  s.summary = s.description
  s.homepage = 'http://github.com/attack/rats'
  s.license = 'MIT'

  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 1.9.2'

  s.files = `git ls-files`.split($/)
  s.test_files = s.files.grep(%r{^spec/})
  s.require_paths = ['lib']

  s.add_development_dependency 'bundler'
end

