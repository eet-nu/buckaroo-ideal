require 'spec_helper'

describe Buckaroo::Ideal::ResponseSignature do
  let(:response) {
    mock :transaction_id => 'transaction_id',
         :timestamp      => 'timestamp',
         :invoice_number => 'invoice_number',
         :reference      => 'reference',
         :currency       => 'EUR',
         :amount         => 12.50,
         :status         => mock(:code => '101'),
         :test_mode      => true
  }
  
  let(:signature) {
    Buckaroo::Ideal::ResponseSignature.new(response, '282538ee4f56f9a1ef8f146b18e2003c')
  }
  
  before do
    Buckaroo::Ideal::Config.stub(:merchant_key).
                            and_return('merchant_key')
    
    Buckaroo::Ideal::Config.stub(:secret_key).
                            and_return('secret_key')
  end
  
  describe '#valid?' do
    it 'returns true if the given signature matches the generated signature' do
      signature.should be_valid
    end
    
    it 'returns false if the given signature does not match the generated signature' do
      signature = Buckaroo::Ideal::ResponseSignature.new(response, 'wrong')
      signature.should_not be_valid
    end
  end
  
  describe '#generated_signature' do
    it 'generates a signature for the given response' do
      expected_salt = [
        'transaction_id', # response.transaction_id
        'timestamp',      # response.timestamp
        'merchant_key',   # config.merchant_key
        'invoice_number', # response.invoice_number
        'reference',      # response.reference
        'EUR',            # response.currency
        1250,             # response.amount (in cents)
        '101',            # response.status.code
        '1',              # response.test_mode
        'secret_key'      # config.secret_key
      ].join
      
      Digest::MD5.should_receive(:hexdigest).with(expected_salt)
      
      signature.generate_signature
    end
  end
end
