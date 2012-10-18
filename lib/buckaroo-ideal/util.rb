module Buckaroo
  module Ideal
    module Util
      extend self
      
      if RUBY_VERSION < "1.9"
        
        require 'iconv'
        
        STRIP_ACCENTS_RE = /[\^~"`']/
        
        def to_normalized_string(string)
          Iconv.iconv('US-ASCII//IGNORE//TRANSLIT', 'UTF-8', string).to_s.gsub(STRIP_ACCENTS_RE, '')
        end
        
      else
        
        require 'transliterator'
        
        def to_normalized_string(string)
          Transliterator.asciify(string.to_s)
        end
        
      end
      
      def to_cents(amount)
        (amount.to_f * 100).round
      end
      
      def from_cents(cents)
        cents.to_f / 100
      end
      
      def to_numeric_boolean(boolean)
        boolean ? 1 : 0
      end
      
      def from_numeric_boolean(number)
        number.to_i == 1
      end
      
      def compact(subject)
        subject = subject.dup
        
        if subject.is_a?(Hash)
          subject.each do |key, value|
            subject.delete(key) unless value
          end
        end
        
        subject
      end
    end
  end
end
