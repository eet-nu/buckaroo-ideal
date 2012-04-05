require 'spec_helper'

describe Buckaroo::Ideal::Order do
  let(:order) { Buckaroo::Ideal::Order.new }
  
  before do
    Buckaroo::Ideal::Config.configure(
      merchant_key:   'merchant_key',
      secret_key:     'secret_key',
      test_mode:      true,
      success_url:    'http://example.com/transaction/success',
      reject_url:     'http://example.com/transaction/reject',
      error_url:      'http://example.com/transaction/error',
      return_method:  'GET',
      style:          'POPUP',
      autoclose_popup: true
    )
  end
  
  it 'has a default currency' do
    order.currency.should == 'EUR'
  end
  
  it 'has a default language' do
    order.language.should == 'NL'
  end
  
  it 'has a default merchant_key from the configuration' do
    order.merchant_key.should == 'merchant_key'
  end
  
  it 'has a default test_mode from the configuration' do
    order.test_mode.should be_true
  end
  
  it 'has a default success_url from the configuration' do
    order.success_url.should == 'http://example.com/transaction/success'
  end
  
  it 'has a default reject_url from the configuration' do
    order.reject_url.should == 'http://example.com/transaction/reject'
  end
  
  it 'has a default error_url from the configuration' do
    order.error_url.should == 'http://example.com/transaction/error'
  end
  
  it 'has a default return_method from the configuration' do
    order.return_method.should == 'GET'
  end
  
  it 'has a default style from the configuration' do
    order.style.should == 'POPUP'
  end
  
  it 'has a default autoclose_popup from the configuration' do
    order.autoclose_popup.should be_true
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
