require 'csv'

module Buckaroo
  module Ideal
    class Status
      class UnknownStatusCode < StandardError; end
      
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
    end
  end
end
