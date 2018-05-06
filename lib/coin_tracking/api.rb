require 'uri'
require 'httparty'
require 'openssl'

module CoinTracking
  class Api
    API_URL = 'https://cointracking.info/api/v1/'
    DEBUG   = false

    def initialize(api_key, secret_key)
      @api_key, @secret_key = api_key, secret_key
    end

    def trades(params = {})
      api_query('getTrades', sanitize_params(params))
    end

    def balance(params = {})
      api_query('getBalance', sanitize_params(params))
    end

    def historical_summary(params = {})
      api_query('getHistoricalSummary', sanitize_params(params))
    end

    def historical_currency(params = {})
      api_query('getHistoricalCurrency', sanitize_params(params))
    end

    def grouped_balance(params = {})
      api_query('getGroupedBalance', sanitize_params(params))
    end

    def gains(params = {})
      api_query('getGains', sanitize_params(params))
    end

    private

    def sanitize_params(params = {})
      %w(start end).each do |key|
        sym = key.to_sym
        params[key] = time_to_unix(params[key]) if params.include?(key)
        params[sym] = time_to_unix(params[sym]) if params.include?(sym)
      end
      params
    end

    def time_to_unix(v)
      case v
      when DateTime, Date
        v.to_time.to_i
      when Time, String
        v.to_i
      when Integer
        v
      else
        raise ArgumentError.new("Invalid timestamp type: #{v.class}.")
      end
    end

    def api_query(action, params = {})
      params   = { method: action, nonce: nonce }.merge(params)
      response = HTTParty.post API_URL, body: params, headers: http_headers(params), debug_output: DEBUG ? $stdout : nil
      CoinTracking::Response.new(response)
    end

    def encoded_params(params)
      HTTParty::HashConversions.to_params(params)
    end

    def signed_params(params)
      OpenSSL::HMAC.hexdigest('sha512', @secret_key, encoded_params(params))
    end

    def nonce
      Time.now.to_i
    end

    def http_headers(params)
      { 'Key' => @api_key,
        'Sign' => signed_params(params),
        'Connection' => 'close',
        'User-Agent' => user_agent }
    end

    def user_agent
      "CoinTracking.rb/#{CoinTracking::VERSION} (#{CoinTracking::SOURCE_URL})"
    end
  end
end