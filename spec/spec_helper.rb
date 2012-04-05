require 'rubygems'
require 'bundler/setup'

require File.expand_path('../../lib/buckaroo-ideal',  __FILE__)

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.mock_with :rspec
  
  config.before do
    Buckaroo::Ideal::Config.reset
  end
end
