require 'rubygems'
require 'finder'

RSpec.configure do |config|
  #if ENV['COVERAGE']
    require 'simplecov'
    SimpleCov.start
  #end

  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end
