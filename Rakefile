require 'rubygems'
require 'puppetlabs_spec_helper/rake_tasks'

require 'puppet-lint'
PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.send("disable_class_inherits_from_params_class")

desc 'Run Tasks [:validate, :spec, :lint]'
task :all => [:validate, :spec, :lint]

task(:default).clear
task :default => :all
