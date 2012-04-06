require 'transliterator'

module Buckaroo
  module Ideal
    module Util
      extend self
      
      def to_normalized_string(string)
        Transliterator.asciify(string)
      end
      
      def to_cents(amount)
        (amount * 100).to_i
      end
      
      def to_numeric_boolean(boolean)
        boolean ? 1 : 0
      end
    end
  end
end
