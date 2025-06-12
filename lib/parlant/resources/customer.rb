# frozen_string_literal: true

require_relative "base"

module Parlant
  module Resources
    # Resource for working with Parlant Customers
    class Customer < Base
      # List all customers
      # @param params [Hash] optional query parameters
      # @return [Array<Hash>] list of customers
      def list(params = {})
        get_request("/customers", params)
      end

      # Get a single customer by ID
      # @param id [String] the customer ID
      # @return [Hash] the customer data
      def get(id)
        get_request("/customers/#{id}")
      end

      # Create a new customer
      # @param attributes [Hash] the customer attributes
      # @option attributes [String] :name The customer name
      # @return [Hash] the created customer
      def create(attributes = {})
        post_request("/customers", attributes)
      end

      # Update a customer
      # @param id [String] the customer ID
      # @param attributes [Hash] the attributes to update
      # @return [Hash] the updated customer
      def update(id, attributes = {})
        put_request("/customers/#{id}", attributes)
      end

      # Delete a customer
      # @param id [String] the customer ID
      # @return [Hash] the API response
      def delete(id)
        delete_request("/customers/#{id}")
      end
    end
  end
end
