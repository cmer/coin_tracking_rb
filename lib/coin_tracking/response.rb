require 'json'

module CoinTracking
  class Response
    attr_reader :http_response

    def initialize(http_response)
      @http_response = http_response
    end

    def to_h
      if @http_response.parsed_response.is_a?(String)
        JSON.parse(@http_response.parsed_response)
      else
        @http_response.parsed_response
      end
    end

    def data
      to_h
    end

    def body
      @http_response.body
    end

    def success?
      data['success'].to_i == 1
    end

    def error?
      !success?
    end

    def method_missing(method_sym, *arguments, &block)
      data.include?(method_sym.to_s) ? data[method_sym.to_s] : super
    end

    def respond_to?(method_sym, include_private = false)
      data.include?(method_sym.to_s) ? true : super
    end
  end
end