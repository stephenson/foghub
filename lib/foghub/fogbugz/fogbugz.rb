require_relative './adapters/http/typhoeus'
require_relative './adapters/xml/cracker'
require_relative './interface'

module Fogbugz
  class << self
    attr_accessor :adapter
  end

  self.adapter = {
    :xml  => Adapter::XML::Cracker,
    :http => Adapter::HTTP::Typhoeus
  }
end
