# frozen_string_literal: true

module Parlant
  # Base error class for all Parlant errors
  class Error < StandardError
    # The HTTP status code returned by the API
    # @return [Integer]
    attr_reader :status_code

    # The error code returned by the API
    # @return [String, nil]
    attr_reader :error_code

    # The error message returned by the API
    # @return [String, nil]
    attr_reader :error_message

    # The raw response body
    # @return [String, nil]
    attr_reader :response_body

    # Initialize a new error
    # @param message [String] the error message
    # @param status_code [Integer, nil] the HTTP status code
    # @param error_code [String, nil] the error code from the API
    # @param error_message [String, nil] the error message from the API
    # @param response_body [String, nil] the raw response body
    def initialize(message, status_code: nil, error_code: nil, error_message: nil, response_body: nil)
      @status_code = status_code
      @error_code = error_code
      @error_message = error_message
      @response_body = response_body
      super(message)
    end
  end

  # Error raised when authentication fails
  class AuthenticationError < Error; end

  # Error raised when a resource is not found
  class ResourceNotFoundError < Error; end

  # Error raised when a request is invalid
  class InvalidRequestError < Error; end

  # Error raised when the API rate limit is exceeded
  class RateLimitExceededError < Error; end

  # Error raised when the API returns a server error
  class ServerError < Error; end

  # Error raised when the API returns an unexpected response
  class UnexpectedResponseError < Error; end
end
