require 'bundler/setup'

require 'jeweler'
require 'rake/testtask'
require 'rdoc/task'


Jeweler::Tasks.new do |gem|
  gem.name = "dicechucker"
  gem.summary = "dice notation (XdY+Z) library"
  gem.description = "creates and rolls die sets using standard XdY+Z notation"
  gem.email = "mark.tabler@fallingmanstudios.net"
  gem.homepage = "http://github.com/marktabler/dicechucker"
  gem.authors = ["Mark Tabler"]
  gem.add_development_dependency "mocha", "~>0.14.0"
  gem.add_development_dependency "rdoc", "~>4.0.1"
  gem.add_development_dependency "simplecov", "~>0.7.1"
  gem.files.exclude "coverage"
  gem.executables = ['roll']
end

Jeweler::GemcutterTasks.new

Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "dicechucker #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

task :default => :test
