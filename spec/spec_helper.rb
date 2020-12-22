require 'bundler/setup'
require 'byebug'

require_relative '../lib/item'
require_relative '../lib/receipt'

Bundler.setup
RSPEC_ROOT = File.dirname __FILE__

RSpec.configure do |config|
end
