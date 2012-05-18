$LOAD_PATH << File.expand_path('..', __FILE__)

module Buckaroo
  module Ideal
    # The banks that are supported by Buckaroo's iDEAL platform
    BANKS = %w[ ABNAMRO  ASNBANK  FRIESLAND
                INGBANK  RABOBANK SNSBANK
                SNSREGIO TRIODOS  LANSCHOT  ]
    
    # The currencies that are supported by Buckaroo's iDEAL platform
    CURRENCIES = %w[ EUR ]
    
    # The languages supported by Buckaroo's user interface:
    LANGUAGES = %w[ NL EN DE FR ]
    
    autoload :VERSION,        'buckaroo-ideal/version'
    autoload :Config,         'buckaroo-ideal/config'
    autoload :Order,          'buckaroo-ideal/order'
    autoload :OrderForm,      'buckaroo-ideal/order_form'
    autoload :OrderSignature, 'buckaroo-ideal/order_signature'
    autoload :Util,           'buckaroo-ideal/util'
  end
end
