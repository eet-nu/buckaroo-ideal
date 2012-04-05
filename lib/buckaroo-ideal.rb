$LOAD_PATH << File.expand_path('..', __FILE__)

module Buckaroo
  module Ideal
    autoload :VERSION, 'buckaroo-ideal/version'
    autoload :Config,  'buckaroo-ideal/config'
    autoload :Order,   'buckaroo-ideal/order'
  end
end
