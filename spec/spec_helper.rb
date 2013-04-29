# encoding: UTF-8  ,

require 'simplecov'

SimpleCov.start do
  add_filter "/spec/"
end

require 'pathname'
require 'rspec'
require 'markify'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.color_enabled = true

  config.order = 'random'
end