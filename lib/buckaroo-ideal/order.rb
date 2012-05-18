require 'active_support/core_ext/module/delegation'

module Buckaroo
  module Ideal
    class Order
      def self.defaults
        { currency: 'EUR' }
      end
      
      # @return [Float] The total amount that this order is for
      attr_accessor :amount
      
      # @return [String] The currency that is being used for the transaction
      attr_accessor :currency
      
      # @return [String] The bank that will be used for the order's transaction.
      attr_accessor :bank
      
      # @return [String] The description for the transaction
      attr_accessor :description
      
      # @return [String] The reference that will be passed to the response URLs
      attr_accessor :reference
      
      # @return [String] The invoice number that is associated with the order
      attr_accessor :invoice_number
      
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
