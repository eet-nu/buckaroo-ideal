require 'spec_helper'

describe Buckaroo::Ideal::OrderForm do
  let(:order) { Buckaroo::Ideal::Order.new            }
  let(:form)  { Buckaroo::Ideal::OrderForm.new(order) }
  
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
  
  it 'has a default language' do
    form.language.should == 'NL'
  end
  
  it 'has a default success_url from the configuration' do
    form.success_url.should == 'http://example.com/transaction/success'
  end
  
  it 'has a default reject_url from the configuration' do
    form.reject_url.should == 'http://example.com/transaction/reject'
  end
  
  it 'has a default error_url from the configuration' do
    form.error_url.should == 'http://example.com/transaction/error'
  end
  
  it 'has a default return_method from the configuration' do
    form.return_method.should == 'GET'
  end
  
  it 'has a default style from the configuration' do
    form.style.should == 'POPUP'
  end
  
  it 'has a default autoclose_popup from the configuration' do
    form.autoclose_popup.should be_true
  end
  
  describe '#gateway_url' do
    it 'returns the configured gateway_url' do
      form.gateway_url.should == Buckaroo::Ideal::Config.gateway_url
    end
  end
  
  describe '#parameters' do
    def parameters; form.parameters; end
    
    it 'has a BPE_Merchant with the configured merchant_key' do
      parameters['BPE_Merchant'].should == 'merchant_key'
      
      Buckaroo::Ideal::Config.merchant_key = 'new_merchant_key'
      parameters['BPE_Merchant'].should == 'new_merchant_key'
    end
    
    it "has a BPE_Amount with the order's amount in cents" do
      order.amount = 19.95
      parameters['BPE_Amount'].should == 1995
    end
    
    it "has a BPE_Currency with the order's currency" do
      parameters['BPE_Currency'].should == 'EUR'
      
      order.currency = 'BHT'
      parameters['BPE_Currency'].should == 'BHT'
    end
    
    it "has a BPE_Invoice with the order's invoice_number" do
      order.invoice_number = 'INV001'
      parameters['BPE_Invoice'].should == 'INV001'
    end
    
    it 'has a BPE_Return_Method with the return_method' do
      parameters['BPE_Return_Method'].should == 'GET'
      
      form.return_method = 'POST'
      parameters['BPE_Return_Method'].should == 'POST'
    end
    
    it 'has a BPE_Style if the style is set' do
      parameters['BPE_Style'].should == 'POPUP'
      
      form.style = 'PAGE'
      parameters['BPE_Style'].should == 'PAGE'
    end
    
    it 'has a BPE_Autoclose_Popup if autoclose_popup is set' do
      parameters['BPE_Autoclose_Popup'].should == 1
      
      form.autoclose_popup = false
      parameters['BPE_Autoclose_Popup'].should == 0
    end
    
    it 'has a generated BPE_Signature2' do
      parameters['BPE_Signature2'].length.should == 32
      
      form.stub(:signature).and_return('signature')
      
      parameters['BPE_Signature2'].should == 'signature'
    end
    
    it 'has a BPE_Language with the language' do
      parameters['BPE_Language'].should == 'NL'
      
      form.language = 'DE'
      parameters['BPE_Language'].should == 'DE'
    end
    
    it 'has a BPE_Mode with the configured test_mode' do
      parameters['BPE_Mode'].should == 1
      
      Buckaroo::Ideal::Config.test_mode = false
      parameters['BPE_Mode'].should == 0
    end
    
    it "has a BPE_Issuer if the order's bank is set" do
      parameters.keys.should_not include 'BPE_Issuer'
      
      order.bank = 'ABNAMRO'
      parameters['BPE_Issuer'].should == 'ABNAMRO'
    end
    
    it "has a BPE_Description if the order's description is set" do
      parameters.keys.should_not include 'BPE_Description'
      
      order.description = 'Your Order Description'
      parameters['BPE_Description'].should == 'Your Order Description'
    end
    
    it 'has a BPE_Reference if the reference is set' do
      parameters.keys.should_not include 'BPE_Reference'
      
      order.reference = 'Reference'
      parameters['BPE_Reference'].should == 'Reference'
    end
    
    it 'has a BPE_Return_Success if the success_url is set' do
      form.success_url = nil
      parameters.keys.should_not include 'BPE_Return_Success'
      
      form.success_url = 'http://example.org/'
      parameters['BPE_Return_Success'].should == 'http://example.org/'
    end
    
    it 'has a BPE_Return_Reject if the reject_url is set' do
      form.reject_url = nil
      parameters.keys.should_not include 'BPE_Return_Reject'
      
      form.reject_url = 'http://example.org/'
      parameters['BPE_Return_Reject'].should == 'http://example.org/'
    end
    
    it 'has a BPE_Return_Error if the error_url is set' do
      form.error_url = nil
      parameters.keys.should_not include 'BPE_Return_Error'
      
      form.error_url = 'http://example.org/'
      parameters['BPE_Return_Error'].should == 'http://example.org/'
    end
  end
end
