# frozen_string_literal: true

require_relative "base"

module Parlant
  module Resources
    # Resource for working with Parlant Guidelines
    class Guideline < Base
      # List all guidelines
      # @param params [Hash] optional query parameters
      # @return [Array<Hash>] list of guidelines
      def list(params = {})
        get_request("/guidelines", params)
      end

      # Get a single guideline by ID
      # @param id [String] the guideline ID
      # @return [Hash] the guideline data
      def get(id)
        get_request("/guidelines/#{id}")
      end

      # Create a new guideline
      # @param attributes [Hash] the guideline attributes
      # @option attributes [String] :text The guideline text
      # @option attributes [Integer] :priority The guideline priority
      # @return [Hash] the created guideline
      def create(attributes = {})
        post_request("/guidelines", attributes)
      end

      # Update a guideline
      # @param id [String] the guideline ID
      # @param attributes [Hash] the attributes to update
      # @return [Hash] the updated guideline
      def update(id, attributes = {})
        put_request("/guidelines/#{id}", attributes)
      end

      # Delete a guideline
      # @param id [String] the guideline ID
      # @return [Hash] the API response
      def delete(id)
        delete_request("/guidelines/#{id}")
      end
    end
  end
end
