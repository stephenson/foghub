require_relative '../test_helper.rb'
require 'foghub/fogbugz/fogbugz'
require 'foghub/fogbugz/adapters/xml/cracker'
require 'foghub/fogbugz/adapters/http/typheous'

class Fogbugz::Adapter::HTTP::Mock
  def request
    ''
  end
end

class Fogbugz::Adapter::XML::Mock
  def self.parse
    ''
  end
end
