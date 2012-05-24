require 'csv'

module Buckaroo
  module Ideal
    class Status
      class UnknownStatusCode < StandardError; end
      
      STATES = {
        completed: %w(071 121 151 171 190 242 243 244 245 246 247 254 255 301
                      401 461 462 463 464 551 601 701 801),
        pending:   %w(000 001 070 090 091 100 105 120 126 135 136 150 156 157
                      170 176 177 253 300 400 460 500 550 600 700 710 790 791
                      792 793 800 811 814 815 831 834),
        failed:    %w(072 073 074 075 076 101 102 103 104 106 122 123 124 125
                      137 138 139 152 153 155 158 159 172 173 175 178 179 201
                      203 204 205 206 207 251 252 260 261 262 302 303 304 305
                      306 309 402 409 410 411 414 421 422 425 466 468 490 491
                      492 501 552 553 554 555 556 560 581 590 602 605 609 610
                      612 690 702 703 704 705 706 707 708 711 712 720 721 802
                      803 804 810 812 813 816 820 821 822 823 824 830 833 835
                      836 890 891 900 901 910 931 932 933 934 935 940 941 942
                      943 944 945 946 947 948 949 950 951 952 953 954 955 956
                      960 961 962 963 964 971 972 973 974 975 976 977 978 980
                      981 982 983 990 991 992 993 999)
      }
      
      CSV_FILE = File.expand_path('../../../files/statuscodes.csv', __FILE__)
      
      attr_reader :code, :message
      
      def self.status_codes(csv_file = CSV_FILE)
        codes = {}
        
        CSV.foreach(csv_file, col_sep: ';') do |row|
          codes[row[0]] = row[1]
        end
        
        codes
      end
      
      def initialize(code)
        if message = self.class.status_codes[code]
          @code    = code
          @message = message
        else
          raise UnknownStatusCode
        end
      end
      
      def state
        STATES.each do |state, codes|
          return state if codes.include? @code
        end
        
        :unknown
      end
      
      def completed?; state == :completed; end
      def pending?;   state == :pending;   end
      def failed?;    state == :failed;    end
      
      def ==(other)
        other.respond_to?(:code) && other.code == code
      end
    end
  end
end
