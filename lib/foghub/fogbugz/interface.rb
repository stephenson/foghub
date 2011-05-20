module Fogbugz
  class Interface
    attr_accessor :options, :http, :xml

    def initialize(options = {})
      @options = {}.merge(options)
      @http = Fogbugz.adapter[:http].new
      @xml = Fogbugz.adapter[:xml].new
    end
  end
end
