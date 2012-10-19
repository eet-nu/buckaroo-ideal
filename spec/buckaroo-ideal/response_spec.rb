require 'spec_helper'

describe Buckaroo::Ideal::Response do
  let(:parameters) {
    {
      'bpe_trx'        => 'transaction_id',
      'bpe_result'     => '801',
      'bpe_invoice'    => 'inv001',
      'bpe_reference'  => 'ref001',
      'bpe_signature'  => 'response_signature_1',
      'bpe_signature2' => 'response_signature_2',
      'bpe_amount'     => '2695',
      'bpe_currency'   => 'EUR',
      'bpe_mode'       => '1',
      'bpe_timestamp'  => '22-05-2012 12:58:13'
    }
  }
  
  let(:response) { Buckaroo::Ideal::Response.new(parameters) }
  
  it 'has a transaction_id' do
    response.transaction_id.should == 'transaction_id'
  end
  
  it 'has a status' do
    response.status.should == Buckaroo::Ideal::Status.new('801')
  end
  
  it 'has an invoice_number' do
    response.invoice_number.should == 'inv001'
  end
  
  it 'has a reference' do
    response.reference.should == 'ref001'
  end
  
  it 'has a signature' do
    response.signature.should be_a Buckaroo::Ideal::ResponseSignature
    response.signature.signature.should == 'response_signature_2'
  end
  
  it 'has an amount' do
    response.amount.should == 26.95
  end
  
  it 'has a currency' do
    response.currency.should == 'EUR'
  end
  
  it 'has a test_mode' do
    response.test_mode.should == true
  end
  
  it 'has a time' do
    response.time.should == Time.local(2012, 05, 22, 12, 58, 13)
  end
  
  it 'has a timestamp' do
    response.timestamp.should == '22-05-2012 12:58:13'
  end
  
  describe '#valid?' do
    it 'returns true if the signature is valid' do
      response.signature.stub(:valid?).and_return(true)
      
      response.should be_valid
    end
    
    it 'returns false if the signature if not valid' do
      response.signature.stub(:valid?).and_return(false)
      
      response.should_not be_valid
    end
  end
end
