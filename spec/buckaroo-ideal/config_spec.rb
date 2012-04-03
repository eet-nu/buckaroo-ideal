require 'spec_helper'

describe Buckaroo::Ideal::Config do
  before do
    Buckaroo::Ideal::Config.configure(
      merchant_key: 'merchant_key',
      secret_key:   'secret_key',
      test_mode:    true
    )
  end
  
  it 'has a merchant_key' do
    Buckaroo::Ideal::Config.merchant_key.should == 'merchant_key'
  end
  
  it 'has a secret_key' do
    Buckaroo::Ideal::Config.secret_key.should == 'secret_key'
  end
  
  it 'has a test_mode' do
    Buckaroo::Ideal::Config.test_mode.should be_true
  end
  
  it 'can be reset to default values' do
    Buckaroo::Ideal::Config.reset
    Buckaroo::Ideal::Config.merchant_key.should be_nil
    Buckaroo::Ideal::Config.secret_key.should   be_nil
    Buckaroo::Ideal::Config.test_mode.should    be_false
  end
end
