require 'active_support/core_ext/module/delegation'
require 'time'

module Buckaroo
  module Ideal
    class Response
      # @return [Hash] The raw parameters that form the heart of the response
      attr_reader :parameters
      
      # @return [String] The unique code that is given to the transaction by
      #   Buckaroo's Payment Gateway
      attr_reader :transaction_id
      
      # @return [Buckaroo::Ideal::Status] The status of the transaction
      attr_reader :status
      
      # @return [String] The reference that was given to the
      #   +Buckaroo::Ideal::Order+
      attr_reader :reference
      
      # @return [String] The invoice_number that was given to the
      #   +Buckaroo::Ideal::Order+
      attr_reader :invoice_number
      
      # @return [Buckaroo::Ideal::ResponseSignature] The signature of the
      #   transaction, which can be used to validate it's authenticity.
      attr_reader :signature
      
      # @return [String] The currency that was used during the transaction
      attr_reader :currency
      
      # @return [Time] The date and time of the transaction
      attr_reader :time
      
      # @return [String] The timestamp of the transaction
      attr_reader :timestamp
      
      # @return [Float] The amount that was transferred during the transaction
      attr_reader :amount
      
      # @return [Boolean] Returns +true+ if the transaction was a test, +false+
      #   if it was real
      attr_reader :test_mode
      
      def initialize(params = {})
        @parameters     = params
        @transaction_id = parameters['bpe_trx']
        @reference      = parameters['bpe_reference']
        @invoice_number = parameters['bpe_invoice']
        @currency       = parameters['bpe_currency']
        @timestamp      = parameters['bpe_timestamp']
        @time           = Time.parse(timestamp)
        @amount         = from_cents(parameters['bpe_amount'])
        @test_mode      = from_numeric_boolean(parameters['bpe_mode'])
        @status         = Status.new(parameters['bpe_result'])
        @signature      = ResponseSignature.new(self, parameters['bpe_signature2'])
      end
      
      def valid?
        signature.valid?
      end
      
      private
      
      include Util
    end
  end
end
