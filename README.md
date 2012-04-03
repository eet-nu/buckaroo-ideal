# Buckaroo::Ideal [![Build Status](https://secure.travis-ci.org/eet-nu/buckaroo-ideal.png)][Travis CI] [![Dependency Status](https://gemnasium.com/eet-nu/buckaroo-ideal.png)][Gemnasium]

A simple Ruby library that aids you in handling iDEAL transactions via the [Buckaroo iDEAL gateway].

## Getting Started

### Installation

Add this line to your application's Gemfile:

    gem 'buckaroo-ideal'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install buckaroo-ideal

### Configuration

You can add code to your initialization process to configure the integration with Buckaroo:

    Buckaroo::Ideal::Config.configure(
      partner_key: "Your Partner Key",
      secret_key:  "Your Secret Key",
      test_mode:   false # or true during development
    )

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[Travis CI]: http://travis-ci.org/eet-nu/buckaroo-ideal
[Gemnasium]: https://gemnasium.com/eet-nu/buckaroo-ideal
[Buckaroo iDEAL Gateway]: http://www.buckaroo.nl/zakelijk/producten/betaalmethoden/ideal.aspx
