# frozen_string_literal: true

require_relative "base"

module Parlant
  module Resources
    # Resource for working with Parlant Sessions
    class Session < Base
      # List all sessions
      # @param params [Hash] optional query parameters
      # @return [Array<Hash>] list of sessions
      def list(params = {})
        get_request("/sessions", params)
      end

      # Get a single session by ID
      # @param id [String] the session ID
      # @return [Hash] the session data
      def get(id)
        get_request("/sessions/#{id}")
      end

      # Create a new session
      # @param attributes [Hash] the session attributes
      # @option attributes [String] :agent_id The agent ID
      # @option attributes [String] :customer_id The customer ID
      # @return [Hash] the created session
      def create(attributes = {})
        post_request("/sessions", attributes)
      end

      # Update a session
      # @param id [String] the session ID
      # @param attributes [Hash] the attributes to update
      # @return [Hash] the updated session
      def update(id, attributes = {})
        put_request("/sessions/#{id}", attributes)
      end

      # Delete a session
      # @param id [String] the session ID
      # @return [Hash] the API response
      def delete(id)
        delete_request("/sessions/#{id}")
      end
    end
  end
end
