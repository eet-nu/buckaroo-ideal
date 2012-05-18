require 'digest/md5'

module Buckaroo
  module Ideal
    #
    # Digital signature generator for +Buckaroo::Ideal::Order+ instances.
    #
    # A digital signature is used to sign your request so the Buckaroo Payment
    # Service can validate that the request was made by your application.
    #
    # A digital signature is composed by generating a MD5 hash of the following
    # values:
    # * Merchant Key:  The +merchant_key+ that is provided by Buckaroo and set
    #   in +Buckaroo::Ideal::Config+.
    # * Invoice Number: The +invoice_number+ that is set in your
    #   +Buckaroo::Ideal::Order+ instance.
    # * Amount: The +amount+ that is set in your +Buckaroo::Ideal::Order+
    #   instance in cents.
    # * Currency: The +currency+ that is set in your +Buckaroo::Ideal::Order+
    #   instance.
    # * Mode: The +test_mode+ that is set in +Buckaroo::Ideal::Config+.
    #
    # To create a signature for an +Buckaroo::Ideal::Order+, instantiate a new
    # +Buckaroo::Ideal::OrderSignature+ and provide the order:
    #
    #     order = Buckaroo::Ideal::Order.new(amount: 100, invoice_number: 'EETNU-123')
    #     signature = Buckaroo::Ideal::Signature.new(order)
    class OrderSignature
      
      # @return [Buckaroo::Ideal::Order] The order that is being signed.
      attr_reader :order
      
      # @return [String] The secret key that is used to sign the order.
      attr_reader :secret
      
      # @return [Boolean] The configured test_mode in +Buckaroo::Ideal::Config+
      delegate :test_mode, to: Config
      
      # @return [String] The configured merchant_key in +Buckaroo::Ideal::Config+
      delegate :merchant_key, to: Config
      
      # Initialize a new +Buckaroo::Ideal::Signature+ instance for the given
      # order.
      #
      # @param [Buckaroo::Ideal::Order] The order that needs to be signed.
      # @param [String] The secret key that is used to sign the order.
      #   Defaults to the configured +Buckaroo::Ideal::Config.secret_key+.
      # @return [Buckaroo::Ideal::Signature] The signature for the order
      #   instance.
      def initialize(order, secret_key = Buckaroo::Ideal::Config.secret_key)
        @order  = order
        @secret = secret_key
      end
      
      def signature
        salt = [
          merchant_key,
          to_normalized_string(order.invoice_number),
          to_cents(order.amount),
          to_numeric_boolean(test_mode),
          secret
        ].join
                
        Digest::MD5.hexdigest(salt)
      end
      alias_method :to_s, :signature
      
      private
      
      include Util
    end
  end
end
