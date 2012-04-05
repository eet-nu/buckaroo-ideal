require 'unicode_utils'

module Buckaroo
  module Ideal
    module Util
      extend self
      
      def to_normalized_string(string)
        UnicodeUtils.compatibility_decomposition(string)
                    .gsub(/[^\x00-\x7F]/, '')
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
