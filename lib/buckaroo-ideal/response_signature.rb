require 'digest/md5'
require 'active_support/core_ext/module/delegation'

module Buckaroo
  module Ideal
    class ResponseSignature
      
      # @return [String] The configured merchant_key in +Buckaroo::Ideal::Config+
      delegate :merchant_key, :to => Config
      
      # @return [String] The configured secret_key in +Buckaroo::Ideal::Config+
      delegate :secret_key,   :to => Config
      
      # @return [String] The signature that was given in the response
      attr_reader :signature
      
      # @return [Buckaroo::Ideal::Response] The response that was signed.
      attr_reader :response
      
      # @return [String] The secret key that is used to sign the order.
      attr_reader :secret
      
      def initialize(response, signature = '')
        @response  = response
        @signature = signature
      end
      
      def valid?
        signature == generate_signature
      end
      
      def generate_signature
        salt = [
          response.transaction_id,
          response.timestamp,
          merchant_key,
          response.invoice_number,
          response.reference,
          response.currency,
          to_cents(response.amount),
          response.status.code,
          to_numeric_boolean(response.test_mode),
          secret_key
        ].join
        
        Digest::MD5.hexdigest(salt)
      end
      
      private
      
      include Util
    end
  end
end
