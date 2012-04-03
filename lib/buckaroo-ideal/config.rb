module Buckaroo
  module Ideal
    class Config
      class << self
        attr_accessor :merchant_key,
                      :secret_key,
                      :test_mode
        
        def configure(settings = {})
          reset
          
          self.merchant_key = settings[:merchant_key]
          self.secret_key   = settings[:secret_key]
          self.test_mode    = settings[:test_mode]
        end
        
        def reset
          self.merchant_key = nil
          self.secret_key   = nil
          self.test_mode    = false
        end
      end
    end
  end
end
