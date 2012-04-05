require 'active_support/core_ext/module/delegation'

module Buckaroo
  module Ideal
    class Order
      def self.defaults
        {
          currency:        'EUR',
          language:        'NL',
          success_url:     Config.success_url,
          reject_url:      Config.reject_url,
          error_url:       Config.error_url,
          return_method:   Config.return_method,
          style:           Config.style,
          autoclose_popup: Config.autoclose_popup
        }
      end
      
      # @return [Boolean] The configured test_mode in +Buckaroo::Ideal::Config+
      delegate :test_mode, to: Config
      
      # @return [String] The configured merchant_key in +Buckaroo::Ideal::Config+
      delegate :merchant_key, to: Config
      
      # @return [Float] The total amount that this order is for
      attr_accessor :amount
      
      # @return [String] The currency that is being used for the transaction
      attr_accessor :currency
      
      # @return [String] The language in wich Buckaroo's user interface is
      #   presented.
      attr_accessor :language
      
      # @return [String] The bank that will be used for the order's transaction.
      attr_accessor :bank
      
      # @return [String] The description for the transaction
      attr_accessor :description
      
      # @return [String] The reference that will be passed to the response URLs
      attr_accessor :reference
      
      # @return [String] The invoice number that is associated with the order
      attr_accessor :invoice_number
      
      # Defaults to the configured +Buckaroo::Ideal::Config.success_url+, but
      # can be overwritten in the +Order+ instance.
      #
      # @return [String] The URL the user will be redirected to after a
      #   successful transaction
      attr_accessor :success_url
      
      # Defaults to the configured +Buckaroo::Ideal::Config.reject_url+, but can
      # be overwritten in the +Order+ instance.
      #
      # @return [String] The URL the user will be redirected to after a failed
      #   transaction
      attr_accessor :reject_url
      
      # Defaults to the configured +Buckaroo::Ideal::Config.error_url+, but can
      # be overwritten in the +Order+ instance.
      #
      # @return [String] The URL the user will be redirected to after an error
      #   occured during the transaction
      attr_accessor :error_url
      
      # Defaults to the configured +Buckaroo::Ideal::Config.return_method+, but
      # can be overwritten in the +Order+ instance.
      #
      # @return [String] The HTTP method that will be used to return the user
      #   back to the application after a transaction
      attr_accessor :return_method
      
      # Defaults to the configured +Buckaroo::Ideal::Config.style+, but can be
      # overwritten in the +Order+ instance.
      #
      # @return [String] The style that is being used
      attr_accessor :style
      
      # Defaults to the configured +Buckaroo::Ideal::Config.autoclose_popup+,
      # but can be overwritten in the +Order+ instance.
      #
      # @return [Boolean] Autoclose the popup after a transaction
      attr_accessor :autoclose_popup
      
      # Initialize a new +Order+ with the given settings. Uses the defaults from
      # +Buckaroo::Ideal::Order.defaults+ for settings that are not specified.
      #
      # @return [Buckaroo::Ideal::Order] The +Order+ instance
      def initialize(settings = {})
        settings = self.class.defaults.merge(settings)
        settings.each do |key, value|
          set key, value
        end
      end
        
      private
      
      def set(key, value)
        instance_variable_set(:"@#{key}", value)
      end
    end
  end
end
