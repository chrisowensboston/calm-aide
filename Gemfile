source "https://rubygems.org"

group :test do
  gem 'rake', '< 11.0'
  gem "puppet", ENV['PUPPET_VERSION'] || '~> 4.9.3'
  gem 'rspec', '>= 3.4.0'
  gem 'rspec-puppet', '>= 2.4.0' 
  gem 'puppetlabs_spec_helper'
  gem 'metadata-json-lint'
  gem 'rspec-puppet-facts'
  gem 'puppet_facts'
  gem 'rubocop', '0.42.0'
  gem 'simplecov', '>= 0.11.0'
  gem 'simplecov-console', :require => false

  gem "puppet-lint-absolute_classname-check"
  gem "puppet-lint-leading_zero-check"
  gem "puppet-lint-trailing_comma-check"
  gem "puppet-lint-version_comparison-check"
  gem "puppet-lint-classes_and_types_beginning_with_digits-check"
  gem "puppet-lint-unquoted_string-check"
  gem 'puppet-lint-resource_reference_syntax'

  gem 'json_pure', '<= 2.0.1' if RUBY_VERSION < '2.0.0'
end

