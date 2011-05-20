module Fogbugz
  module Adapter
    module HTTP
      class Typhoeus
        attr_accessor :uri

        def initialize(options = {})
          @uri = options[:uri]
        end
      end
    end
  end
end
