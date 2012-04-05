# encoding: utf-8
require 'spec_helper'

describe Buckaroo::Ideal::Util do
  describe '#to_normalized_string' do
    it 'translates utf-8 characters to ASCII equivalents' do
      result = Buckaroo::Ideal::Util.to_normalized_string('îñtërnâtiônàlizâtiôn')
      result.should == 'internationalization'
    end
  end
  
  describe '#to_cents' do
    it 'converts integer amounts to cents' do
      Buckaroo::Ideal::Util.to_cents(10).should == 1000
    end
    
    it 'converts float amounts to cents' do
      Buckaroo::Ideal::Util.to_cents(12.50123).should == 1250
    end
  end
  
  describe '#to_numeric_boolean' do
    it 'converts "true" to "1"' do
      Buckaroo::Ideal::Util.to_numeric_boolean(true).should == 1
    end
    
    it 'converts "false" to "0"' do
      Buckaroo::Ideal::Util.to_numeric_boolean(false).should == 0
    end
  end
end
