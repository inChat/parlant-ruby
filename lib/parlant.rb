# frozen_string_literal: true

require "json"
require "http"
require "parlant/version"
require "parlant/configuration"
require "parlant/error"
require "parlant/client"
require "parlant/resources/base"
require "parlant/resources/agent"
require "parlant/resources/customer"
require "parlant/resources/session"
require "parlant/resources/guideline"

# Main namespace for the Parlant Ruby client library.
# This library provides a Ruby interface to the Parlant API.
module Parlant
  class << self
    attr_writer :configuration

    # Returns the global configuration
    # @return [Parlant::Configuration] the global configuration
    def configuration
      @configuration ||= Configuration.new
    end

    # Configure the library with the given block
    # @yield [config] Configuration object that can be modified
    # @example
    #   Parlant.configure do |config|
    #     config.api_key = "your-api-key"
    #   end
    def configure
      yield(configuration)
    end

    # Create a new client instance with the given configuration
    # @param config [Hash] configuration options
    # @return [Parlant::Client] a new client instance
    def client(config = {})
      Client.new(config)
    end
  end
end
