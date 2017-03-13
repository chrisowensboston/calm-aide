require 'rubygems'
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'
require 'metadata-json-lint/rake_task'
require 'rubocop/rake_task'



module TempFixForRakeLastComment
  def last_comment
    last_description
  end
end

RuboCop::RakeTask.new

Rake::Application.send :include, TempFixForRakeLastComment
# puppet-lint parameters per puppet approved criteria
# https://forge.puppetlabs.com/approved/criteria#validation
PuppetLint.configuration.fail_on_warnings = true
PuppetLint.configuration.send("disable_80chars")
PuppetLint.configuration.send("relative")
# http://puppet-lint.com/checks/class_inherits_from_params_class/
PuppetLint.configuration.send('disable_class_inherits_from_params_class')
# http://puppet-lint.com/checks/class_parameter_defaults/
PuppetLint.configuration.send('disable_class_parameter_defaults')
# Approved criteria disable these two but lets be a bit more stringent
#PuppetLint.configuration.send('disable_documentation')
#PuppetLint.configuration.send('disable_single_quote_string_with_variables')
PuppetLint.configuration.log_format = "%{path}:%{line}:%{check}:%{KIND}:%{message}"

exclude_paths = [
  "bundle/**/*",
  "pkg/**/*",
  "vendor/**/*",
  "spec/**/*",
]
PuppetLint.configuration.ignore_paths = exclude_paths
PuppetLint::RakeTask.new :lint do |config|
  config.ignore_paths = exclude_paths
end
PuppetSyntax.exclude_paths = exclude_paths

desc "Run syntax, lint, and spec tests."
task :test => [
  :metadata_lint,
  :syntax,
  :lint,
  :rubocop,
  :spec,
]
