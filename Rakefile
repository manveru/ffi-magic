require 'rake'
require 'rake/clean'
require 'rubygems/package_task'
require 'time'
require 'date'

PROJECT_SPECS = Dir['spec/**/*.rb']
PROJECT_MODULE = 'Magic'
PROJECT_VERSION = (ENV['VERSION'] || Date.today.strftime("%Y.%m.%d")).dup

GEMSPEC = Gem::Specification.new{|s|
  s.name         = 'ffi-magic'
  s.author       = "Michael 'manveru' Fellinger"
  s.summary      = "FFI binding for libmagic."
  s.email        = 'm.fellinger@gmail.com'
  s.homepage     = 'http://github.com/manveru/ffi-magic'
  s.platform     = Gem::Platform::RUBY
  s.version      = PROJECT_VERSION
  s.files        = `git ls-files`.split("\n").sort
  s.has_rdoc     = true
  s.require_path = 'lib'
  s.executables = []
  s.bindir = "bin"

  s.add_runtime_dependency('ffi', '~> 1.0.7')
}

Dir['tasks/*.rake'].each{|f| import(f) }

task :default => [:bacon]

CLEAN.include('')
