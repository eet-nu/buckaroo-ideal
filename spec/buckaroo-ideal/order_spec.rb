require 'spec_helper'

describe Buckaroo::Ideal::Order do
  let(:order) { Buckaroo::Ideal::Order.new }
  
  before do
    Buckaroo::Ideal::Config.configure(
      :merchant_key    => 'merchant_key',
      :secret_key      => 'secret_key',
      :test_mode       => true,
      :success_url     => 'http://example.com/transaction/success',
      :reject_url      => 'http://example.com/transaction/reject',
      :error_url       => 'http://example.com/transaction/error',
      :return_method   => 'GET',
      :style           => 'POPUP',
      :autoclose_popup => true
    )
  end
  
  it 'has a default currency' do
    order.currency.should == 'EUR'
  end
  
  it 'does not have a default amount' do
    order.amount.should be_nil
  end
  
  it 'does not have a default bank' do
    order.bank.should be_nil
  end
  
  it 'does not have a default description' do
    order.description.should be_nil
  end
  
  it 'does not have a default reference' do
    order.reference.should be_nil
  end
  
  it 'does not have a default invoice_number' do
    order.invoice_number.should be_nil
  end
end
