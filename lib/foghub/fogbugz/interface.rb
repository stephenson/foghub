module Fogbugz
  class Interface
    class RequestError < StandardError; end
    
    attr_accessor :options, :http, :xml, :token

    def initialize(options = {})
      @options = {}.merge(options)
      @http = Fogbugz.adapter[:http].new
      @xml = Fogbugz.adapter[:xml].new
    end

    def authenticate
      @token ||= @http.request :logon, { 
        :email    => @options[:email],
        :password => @options[:password]
      }
    end

    def command(action, parameters)
      raise RequestError, 'No token available, #authenticate first' unless @token
      @http.request(action, :token => @token, :params => parameters)
    end
  end
end
