# CoinTracking.rb

A Ruby client for CoinTracking.info

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'coin_tracking'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install coin_tracking

## Usage

```ruby
require 'coin_tracking'
api = CoinTracking::Api.new API_KEY, SECRET_KEY

api.trades
api.balance
api.historical_summary
api.historical_currency
api.grouped_balance
api.gains

# Optionally, you can pass a Hash with additional parameters, as documented at https://cointracking.info/api/api.php.
# Note that `start` and `end` are special parameters that accept DateTime, Time or a Unix timestamp. This gem does the conversion for you.

api.trades(limit: 100, order: 'DESC', start: 1.year.ago, end: 1525486520)

# Each call returns a CoinTracking::Response object. Here are some of the methods that are available:

response.success?      # => true/false
response.data          # => Hash
response.http_response # => Raw response from HTTParty
response.foobar        # => Syntactic sugar. Same as `response.data['foobar']`.
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cmer/coin_tracking_rb.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
