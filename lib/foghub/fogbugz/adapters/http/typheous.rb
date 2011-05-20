module Fogbugz
  module Adapter
    module HTTP
      class Typheous
        attr_accessor :uri

        def initialize(options = {})
          @uri = options[:uri]
        end
      end
    end
  end
end
