require 'spec_helper'

describe Buckaroo::Ideal::Status do
  let(:status) { Buckaroo::Ideal::Status.new('000') }
  
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
  
  describe '#state' do
    %w(071 121 151 171 190 242 243 244 245 246 247 254 255 301 401 461 462 463
       464 551 601 701 801).each do |code|
      message = Buckaroo::Ideal::Status.status_codes[code]
      
      it "returns :completed for code #{code} (#{message})" do
        status = Buckaroo::Ideal::Status.new(code)
        status.state.should == :completed
      end
    end
    
    %w(000 001 070 090 091 100 105 120 126 135 136 150 156 157 170 176 177 253
       300 400 460 500 550 600 700 710 790 791 792 793 800 811 814 815 831 834).each do |code|
      message = Buckaroo::Ideal::Status.status_codes[code]
      
      it "returns :pending for code #{code} (#{message})" do
        status = Buckaroo::Ideal::Status.new(code)
        status.state.should == :pending
      end
    end
    
    %w(264 541 345 372 390 392).each do |code|
      message = Buckaroo::Ideal::Status.status_codes[code]
      
      it "returns :unknown for code #{code} (#{message})" do
        status = Buckaroo::Ideal::Status.new(code)
        status.state.should == :unknown
      end
    end
    
    %w(072 073 074 075 076 101 102 103 104 106 122 123 124 125 137 138 139 152
       153 155 158 159 172 173 175 178 179 201 203 204 205 206 207 251 252 260
       261 262 302 303 304 305 306 309 402 409 410 411 414 421 422 425 466 468
       490 491 492 501 552 553 554 555 556 560 581 590 602 605 609 610 612 690
       702 703 704 705 706 707 708 711 712 720 721 802 803 804 810 812 813 816
       820 821 822 823 824 830 833 835 836 890 891 900 901 910 931 932 933 934
       935 940 941 942 943 944 945 946 947 948 949 950 951 952 953 954 955 956
       960 961 962 963 964 971 972 973 974 975 976 977 978 980 981 982 983 990
       991 992 993 999).each do |code|
      message = Buckaroo::Ideal::Status.status_codes[code]
      
      it "returns :unknown for code #{code} (#{message})" do
        status = Buckaroo::Ideal::Status.new(code)
        status.state.should == :failed
      end
    end
  end
  
  describe '#completed?' do
    it 'returns true if the state is completed' do
      status.stub(:state).and_return(:completed)
      status.should be_completed
    end
    
    it 'returns false if the state is not completed' do
      status.stub(:state).and_return(:unknown)
      status.should_not be_completed
    end
  end
  
  describe '#pending?' do
    it 'returns true if the state is pending' do
      status.stub(:state).and_return(:pending)
      status.should be_pending
    end
    
    it 'returns false if the state is not pending' do
      status.stub(:state).and_return(:unknown)
      status.should_not be_pending
    end
  end
  
  describe '#failed?' do
    it 'returns true if the state is failed' do
      status.stub(:state).and_return(:failed)
      status.should be_failed
    end
    
    it 'returns false if the state is not failed' do
      status.stub(:state).and_return(:unknown)
      status.should_not be_failed
    end
  end
end
