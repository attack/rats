# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rats}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mark G"]
  s.date = %q{2010-03-31}
  s.description = %q{A ruby class to help with using the Alberta Township System}
  s.email = %q{rats@attackcorp.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "lib/rats.rb",
     "lib/rats/base.rb",
     "lib/rats/boundaries.rb",
     "lib/rats/data.rb",
     "lib/rats/data/base.rb",
     "lib/rats/data/meridian.rb",
     "lib/rats/data/quarter.rb",
     "lib/rats/data/range.rb",
     "lib/rats/data/section.rb",
     "lib/rats/data/township.rb",
     "spec/data/data_spec.rb",
     "spec/data/meridian_spec.rb",
     "spec/data/quarter_spec.rb",
     "spec/data/range_spec.rb",
     "spec/data/section_spec.rb",
     "spec/data/township_spec.rb",
     "spec/rats_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/attack/rats}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{A ruby class to help with using the Alberta Township System}
  s.test_files = [
    "spec/data/data_spec.rb",
     "spec/data/meridian_spec.rb",
     "spec/data/quarter_spec.rb",
     "spec/data/range_spec.rb",
     "spec/data/section_spec.rb",
     "spec/data/township_spec.rb",
     "spec/rats_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

