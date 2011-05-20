module Fogbugz
  module Adapter
    module HTTP
      class Typhoeus
        attr_accessor :uri

        def initialize(options = {})
          @uri = options[:uri]
        end

        def request(action, options)
          query = Typhoeus::Request.new("#{uri}/api.asp",
                                        :params => options[:params])
          query.body
        end
      end
    end
  end
end
