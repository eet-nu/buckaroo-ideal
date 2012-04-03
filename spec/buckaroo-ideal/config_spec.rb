require 'spec_helper'

describe Buckaroo::Ideal::Config do
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
  
  subject { Buckaroo::Ideal::Config }
  
  it 'has a merchant_key' do
    subject.merchant_key.should == 'merchant_key'
  end
  
  it 'has a secret_key' do
    subject.secret_key.should == 'secret_key'
  end
  
  it 'has a test_mode' do
    subject.test_mode.should be_true
  end
  
  it 'has a success_url' do
    subject.success_url.should == 'http://example.com/transaction/success'
  end
  
  it 'has a reject_url' do
    subject.reject_url.should == 'http://example.com/transaction/reject'
  end
  
  it 'has a error_url' do
    subject.error_url.should == 'http://example.com/transaction/error'
  end
  
  it 'has a return_method' do
    subject.return_method.should == 'GET'
  end
  
  it 'has a style' do
    subject.style.should == 'POPUP'
  end
  
  it 'has a autoclose_popup setting' do
    subject.autoclose_popup.should be_true
  end
  
  it 'can be reset to default values' do
    subject.reset
    subject.merchant_key.should    be_nil
    subject.secret_key.should      be_nil
    subject.test_mode.should       be_false
    subject.success_url.should     be_nil
    subject.reject_url.should      be_nil
    subject.error_url.should       be_nil
    subject.return_method.should   == 'POST'
    subject.style.should           == 'PAGE'
    subject.autoclose_popup.should be_false
  end
end
