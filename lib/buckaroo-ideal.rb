$LOAD_PATH << File.expand_path('..', __FILE__)

module Buckaroo
  module Ideal
    autoload :VERSION,        'buckaroo-ideal/version'
    autoload :Config,         'buckaroo-ideal/config'
    autoload :Order,          'buckaroo-ideal/order'
    autoload :OrderSignature, 'buckaroo-ideal/order_signature'
    autoload :Util,           'buckaroo-ideal/util'
  end
end
