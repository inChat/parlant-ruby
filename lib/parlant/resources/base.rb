# frozen_string_literal: true

module Parlant
  module Resources
    # Base class for all API resources
    class Base
      # Initialize a new resource
      # @param client [Parlant::Client] the API client
      def initialize(client)
        @client = client
      end

      protected

      # Make a GET request
      # @param path [String] the API path
      # @param params [Hash] the query parameters
      # @return [Hash] the API response
      def get_request(path, params = {})
        @client.request(:get, path, params: params)
      end

      # Make a POST request
      # @param path [String] the API path
      # @param data [Hash] the request body
      # @return [Hash] the API response
      def post_request(path, data = {})
        @client.request(:post, path, data: data)
      end

      # Make a PUT request
      # @param path [String] the API path
      # @param data [Hash] the request body
      # @return [Hash] the API response
      def put_request(path, data = {})
        @client.request(:put, path, data: data)
      end

      # Make a DELETE request
      # @param path [String] the API path
      # @return [Hash] the API response
      def delete_request(path)
        @client.request(:delete, path)
      end
    end
  end
end
