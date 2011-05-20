require 'typhoeus'

module Fogbugz
  module Adapter
    module HTTP
      class Typhoeuser
        attr_accessor :uri

        def initialize(options = {})
          @uri = options[:uri]
        end

        def request(action, options)
          params = {:cmd => action}.merge(options[:params])
          query = Typhoeus::Request.get("#{uri}/api.asp",
                                        :params => params)
          query.body
        end
      end
    end
  end
end
