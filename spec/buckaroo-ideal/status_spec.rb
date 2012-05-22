require 'spec_helper'

describe Buckaroo::Ideal::Status do
  describe '.status_codes' do
    let(:csv_file) { File.expand_path('../../fixtures/statuscodes.csv', __FILE__) }
    
    it 'reads and returns the status codes from the given csv file' do
      codes = Buckaroo::Ideal::Status.status_codes(csv_file)
      
      codes['000'].should == 'De credit card transactie is pending.'
      codes['001'].should == 'De credit card transactie is pending. De MPI-status van de klant wordt gecheckt.'
      codes['007'].should be_nil
    end
    
    it 'reads and returns the status codes from the bundled csv file' do
      codes = Buckaroo::Ideal::Status.status_codes
      codes['000'].should == 'De credit card transactie is pending.'
      codes['104'].should == 'De kaart is verlopen.'
      codes['999'].should == 'Er is een fout opgetreden waarvan de oorzaak vooralsnog onbekend is. We zullen de storing zo snel mogelijk verhelpen.'
    end
  end
  
  describe '#initialize' do
    it 'returns a Status with the code given' do
      status = Buckaroo::Ideal::Status.new('000')
      status.code.should == '000'
    end
    
    it 'returns a Status with the message of the given code' do
      status = Buckaroo::Ideal::Status.new('000')
      status.message.should == 'De credit card transactie is pending.'
    end
    
    it 'throws an UnknownStatusCode exception if the given code is invalid' do
      expect {
        Buckaroo::Ideal::Status.new('007')
      }.to raise_error Buckaroo::Ideal::Status::UnknownStatusCode
    end
  end
  
  describe '#==' do
    it 'returns true if the statuses have the same code' do
      Buckaroo::Ideal::Status.new('000').should == Buckaroo::Ideal::Status.new('000')
    end
  end
end
