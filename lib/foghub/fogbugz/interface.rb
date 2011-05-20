module Fogbugz
  class Interface
    class RequestError < StandardError; end
    class InitializationError < StandardError; end
    
    attr_accessor :options, :http, :xml, :token

    def initialize(options = {})
      @options = {}.merge(options)
      raise InitializationError, "Must supply URI (e.g. http://fogbugz.company.com)" unless options[:uri]
      @http = Fogbugz.adapter[:http].new
      @xml = Fogbugz.adapter[:xml].new
    end

    def authenticate
      @token ||= @http.request :logon, { 
        :email    => @options[:email],
        :password => @options[:password]
      }
    end

    def command(action, parameters = {})
      raise RequestError, 'No token available, #authenticate first' unless @token
      @http.request action, { 
        :token  => @token, 
        :params => parameters.merge(options[:params] || {})
      }
    end
  end
end
