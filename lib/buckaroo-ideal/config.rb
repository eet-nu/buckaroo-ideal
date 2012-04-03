#
# Configuration singleton for storing settings required for making transactions.
#
module Buckaroo
  module Ideal
    class Config
      class << self
        DEFAULTS = {
          merchant_key: nil,
          secret_key:   nil,
          test_mode:    false
        }
        
        # @return [String] The merchant-key supllied by Buckaroo
        attr_accessor :merchant_key
        
        # @return [String] The shared secret key that is used to sign
        #   transaction requests
        attr_accessor :secret_key
        
        # @return [Boolean] Enable/disables test mode. If set to +true+, no
        #   money is actually transferred by completing a transaction
        attr_accessor :test_mode
        
        # Configure the integration with Buckaroo
        def configure(settings = {})
          DEFAULTS.merge(settings).each do |key, value|
            set key, value
          end
        end
        
        # Reset the configuration to the default values
        def reset
          configure({})
        end
        
        private
        
        def set(key, value)
          instance_variable_set(:"@#{key}", value)
        end
      end
    end
  end
end
