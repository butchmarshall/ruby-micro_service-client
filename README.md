[![Gem Version](https://badge.fury.io/rb/micro_service-client.svg)](http://badge.fury.io/rb/micro_service-client)
[![Build Status](https://travis-ci.org/butchmarshall/ruby-micro_service-client.svg?branch=master)](https://travis-ci.org/butchmarshall/ruby-micro_service-client)

# MicroService::Client

ActiveRecord MicroService implementation that persists the details of client installations.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'micro_service-client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install micro_service-client

then run

```ruby
rails generate micro_service:client:active_record
```

## Usage

To the ActiveRecord model:

```ruby
MicroService::Client.new(...)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/butchmarshall/ruby-micro_service-client.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

