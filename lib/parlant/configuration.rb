# frozen_string_literal: true

module Parlant
  # Configuration class for the Parlant client
  class Configuration
    # The API key used for authentication
    # @return [String]
    attr_accessor :api_key

    # The base URL for the Parlant API
    # @return [String]
    attr_accessor :base_url

    # The timeout for HTTP requests in seconds
    # @return [Integer]
    attr_accessor :timeout

    # The maximum number of retries for failed requests
    # @return [Integer]
    attr_accessor :max_retries

    # The logger instance
    # @return [Logger, nil]
    attr_accessor :logger

    # Initialize a new configuration with default values
    def initialize
      @base_url = "https://api.parlant.io"
      @timeout = 30
      @max_retries = 3
      @api_key = ENV.fetch("PARLANT_API_KEY", nil)
      @logger = nil
    end
  end
end
