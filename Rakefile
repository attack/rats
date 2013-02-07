require "bundler/gem_tasks"

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.rspec_opts = ["-c"]
end

task :default => :spec

require 'rdoc/task'
RDoc::Task.new do |rdoc|
  version = Rats::VERSION

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "rats #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
