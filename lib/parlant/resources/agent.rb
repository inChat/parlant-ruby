# frozen_string_literal: true

require_relative "base"

module Parlant
  module Resources
    # Resource for working with Parlant Agents
    class Agent < Base
      # List all agents
      # @param params [Hash] optional query parameters
      # @return [Array<Hash>] list of agents
      def list(params = {})
        get_request("/agents", params)
      end

      # Get a single agent by ID
      # @param id [String] the agent ID
      # @return [Hash] the agent data
      def get(id)
        get_request("/agents/#{id}")
      end

      # Create a new agent
      # @param attributes [Hash] the agent attributes
      # @option attributes [String] :name The agent name
      # @option attributes [String] :description The agent description
      # @option attributes [Integer] :max_engine_iterations The maximum number of engine iterations
      # @return [Hash] the created agent
      def create(attributes = {})
        post_request("/agents", attributes)
      end

      # Update an agent
      # @param id [String] the agent ID
      # @param attributes [Hash] the attributes to update
      # @return [Hash] the updated agent
      def update(id, attributes = {})
        put_request("/agents/#{id}", attributes)
      end

      # Delete an agent
      # @param id [String] the agent ID
      # @return [Hash] the API response
      def delete(id)
        delete_request("/agents/#{id}")
      end

      protected

      # Make a GET request (renamed to avoid method conflict)
      # @param path [String] the API path
      # @param params [Hash] the query parameters
      # @return [Hash] the API response
      def get_request(path, params = {})
        @client.request(:get, path, params: params)
      end

      # Make a DELETE request (renamed to avoid method conflict)
      # @param path [String] the API path
      # @return [Hash] the API response
      def delete_request(path)
        @client.request(:delete, path)
      end
    end
  end
end
