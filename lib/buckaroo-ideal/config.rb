module Buckaroo
  module Ideal
    class Config
      class << self
        DEFAULTS = {
          merchant_key: nil,
          secret_key:   nil,
          test_mode:    false
        }
        
        attr_accessor :merchant_key,
                      :secret_key,
                      :test_mode
        
        def configure(settings = {})
          DEFAULTS.merge(settings).each do |key, value|
            set key, value
          end
        end
        
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
