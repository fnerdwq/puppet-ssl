source 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? "= #{ENV['PUPPET_VERSION']}" : ['>= 3.2']

group :development, :test do
  gem 'puppet-lint', '> 1.0.0'

  gem 'rspec'
  gem 'rspec-puppet', :git => 'https://github.com/rodjek/rspec-puppet'
  gem 'puppetlabs_spec_helper'

  gem 'beaker'
  gem 'beaker-rspec'
  gem 'pry'

  if RUBY_VERSION <= '1.9.0'
    gem 'activesupport', '< 4.0.0'
    gem 'nokogiri', '< 1.6.0'
    gem 'mime-types', '< 2.0.0'
  end
end

gem 'puppet', puppetversion

