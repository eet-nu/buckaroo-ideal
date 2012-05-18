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
      Buckaroo::Ideal::Util.to_cents(12.4954321).should == 1250
    end
  end
  
  describe '#from_cents' do
    it 'converts cents to their real amount' do
      Buckaroo::Ideal::Util.from_cents(1995).should == 19.95
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
  
  describe '#compact' do
    it 'removes keys from hashes if they do not have a value' do
      result = Buckaroo::Ideal::Util.compact({ 'key' => nil })
      result.keys.should_not include 'key'
    end
    
    it 'preserves keys and values in hashes if they have a value' do
      result = Buckaroo::Ideal::Util.compact({ 'key' => 'value' })
      result.keys.should include 'key'
      result['key'].should == 'value'
    end
  end
end
