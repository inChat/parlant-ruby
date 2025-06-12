# frozen_string_literal: true

require "logger"

module Parlant
  # Client for interacting with the Parlant API
  class Client
    # Initialize a new client
    # @param options [Hash] client configuration options
    # @option options [String] :api_key The API key for authentication
    # @option options [String] :base_url The base URL for the API
    # @option options [Integer] :timeout The timeout for HTTP requests in seconds
    # @option options [Integer] :max_retries The maximum number of retries for failed requests
    # @option options [Logger] :logger The logger instance
    def initialize(options = {})
      @config = Configuration.new

      options.each do |key, value|
        @config.send("#{key}=", value) if @config.respond_to?("#{key}=")
      end

      @http = build_http_client

      # Initialize resources
      @agents = Resources::Agent.new(self)
      @customers = Resources::Customer.new(self)
      @sessions = Resources::Session.new(self)
      @guidelines = Resources::Guideline.new(self)
    end

    # Access the agents resource
    # @return [Parlant::Resources::Agent]
    attr_reader :agents

    # Access the customers resource
    # @return [Parlant::Resources::Customer]
    attr_reader :customers

    # Access the sessions resource
    # @return [Parlant::Resources::Session]
    attr_reader :sessions

    # Access the guidelines resource
    # @return [Parlant::Resources::Guideline]
    attr_reader :guidelines

    # Make a request to the Parlant API
    # @param method [Symbol] the HTTP method (:get, :post, :put, :delete)
    # @param path [String] the API path
    # @param params [Hash] query parameters
    # @param data [Hash] body data
    # @return [Hash] the parsed JSON response
    def request(method, path, params: {}, data: nil)
      url = "#{@config.base_url}#{path}"

      headers = {
        "Authorization" => "Bearer #{@config.api_key}",
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }

      response = execute_with_retry do
        case method
        when :get
          @http.get(url, params: params, headers: headers)
        when :post
          @http.post(url, json: data, headers: headers)
        when :put
          @http.put(url, json: data, headers: headers)
        when :delete
          @http.delete(url, headers: headers)
        else
          raise ArgumentError, "Unsupported HTTP method: #{method}"
        end
      end

      handle_response(response)
    end

    private

    def build_http_client
      HTTP.timeout(@config.timeout)
    end

    def execute_with_retry
      retries = 0

      begin
        yield
      rescue HTTP::Error, Timeout::Error => e
        retries += 1
        raise Error, "Request failed after #{retries} retries: #{e.message}" unless retries <= @config.max_retries

        # Exponential backoff with jitter
        sleep_time = (2**retries) + rand(0.1..0.5)
        @config.logger&.warn("Parlant API request failed: #{e.message}. Retrying in #{sleep_time} seconds...")
        sleep(sleep_time)
        retry
      end
    end

    def handle_response(response)
      case response.status
      when 200..299
        parse_json(response.body.to_s)
      when 401
        raise AuthenticationError.new(
          "Authentication failed",
          status_code: response.status,
          response_body: response.body.to_s
        )
      when 404
        raise ResourceNotFoundError.new(
          "Resource not found",
          status_code: response.status,
          response_body: response.body.to_s
        )
      when 422
        body = parse_json(response.body.to_s)
        raise InvalidRequestError.new(
          body["message"] || "Invalid request",
          status_code: response.status,
          error_code: body["code"],
          error_message: body["message"],
          response_body: response.body.to_s
        )
      when 429
        raise RateLimitExceededError.new(
          "Rate limit exceeded",
          status_code: response.status,
          response_body: response.body.to_s
        )
      when 500..599
        raise ServerError.new(
          "Server error",
          status_code: response.status,
          response_body: response.body.to_s
        )
      else
        raise UnexpectedResponseError.new(
          "Unexpected response with status code: #{response.status}",
          status_code: response.status,
          response_body: response.body.to_s
        )
      end
    end

    def parse_json(body)
      return {} if body.nil? || body.empty?

      JSON.parse(body)
    rescue JSON::ParserError
      raise UnexpectedResponseError.new(
        "Failed to parse JSON response",
        response_body: body
      )
    end
  end
end
