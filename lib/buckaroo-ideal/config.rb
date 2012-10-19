module Buckaroo
  module Ideal
    #
    # Configuration singleton for storing settings required for making
    # transactions.
    #
    class Config
      class << self
        # The gateway URL that is used to post form data to.
        #
        # @return [String] The gateway URL
        attr_accessor :gateway_url
        
        # The merchant-key is supllied by Buckaroo. Every application MUST have
        # it's own merchant key.
        #
        # @return [String] The merchant-key for the application
        attr_accessor :merchant_key
        
        # The secret_key should only be known by your application and Buckaroo.
        # It is used to sign orders and validate transactions.
        #
        # @return [String] The shared secret key that is used to sign
        #   transaction requests
        attr_accessor :secret_key
        
        # If test_mode is enabled, transactions will be registered by Buckaroo,
        # but clients will not be forwared to the iDEAL page of their bank.
        #
        # Clients will be redirected back to the success_url of your application
        #
        # @return [Boolean] Test mode on/off
        attr_accessor :test_mode
        
        # @return [String] The URL the user will be redirected to after a
        #   successful transaction
        attr_accessor :success_url
        
        # @return [String] The URL the user will be redirected to after a failed
        #   transaction
        attr_accessor :reject_url
        
        # @return [String] The URL the user will be redirected to after an error
        #   occured during the transaction
        attr_accessor :error_url
        
        # @return [String] The HTTP method that will be used to return the user
        #   back to the application after a transaction
        attr_accessor :return_method
        
        # There are 2 styles that you can use to integrate Buckaroo iDEAL:
        # * POPUP - The transaction is performed in a popup
        # * PAGE  - The transaction is performed in the original window
        #
        # @return [String] The style that is being used
        attr_accessor :style
        
        # If the POPUP style is being used, you can autoclose the popup after
        # a transaction. You will have to provide information about the
        # transaction to the user on the page he will arrive on.
        #
        # @return [Boolean] Autoclose the popup after a transaction
        attr_accessor :autoclose_popup
        
        # Default settings
        def defaults
          {
            :gateway_url     =>  'https://payment.buckaroo.nl/gateway/ideal_payment.asp',
            :merchant_key    =>  nil,
            :secret_key      =>  nil,
            :test_mode       =>  false,
            :success_url     =>  nil,
            :reject_url      =>  nil,
            :error_url       =>  nil,
            :return_method   => 'POST',
            :style           => 'PAGE',
            :autoclose_popup => false
          }
        end
        
        # Configure the integration with Buckaroo
        def configure(settings = {})
          defaults.merge(settings).each do |key, value|
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
