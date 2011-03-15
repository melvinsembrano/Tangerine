$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'timecop'
require 'factory_girl'
require 'vcr'
require 'tangerine'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

VCR.config do |c|
  c.cassette_library_dir = 'spec/support/vcr_cassettes'
  c.stub_with :fakeweb
end

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros
end

