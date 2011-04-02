require_relative '../foghub'
require_relative '../parser'

require 'minitest/unit'
require 'minitest/autorun'
require 'rack/test'

ENV['RACK_ENV'] = 'test'

class MiniTest::Unit::TestCase
  include Rack::Test::Methods
end
