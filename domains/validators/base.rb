# frozen_string_literal: true
# rbs_inline: enabled

module Domains
  module Validators
    class Base
      # @rbs @object: untyped
      # @rbs @errors: Errors
      attr_reader :object, :errors

      def initialize(domain_object)
        @object = domain_object
        @errors = Errors.new
      end
    end

    class Errors

      # @rbs @errors: Array[String]

      def initialize
        @errors = []
      end

      # @rbs (message: String) -> void
      def add(message:)
        @errors << message
      end

      # @rbs () -> bool
      def empty?
        @errors.empty?
      end

      # @rbs () -> String
      def full_messages
        @errors.join(', ')
      end
    end

    class Error < StandardError
      # @rbs @errors: Errors

      # @rbs (Errors) -> void
      def initialize(errors)
        @errors = errors
        message = errors.to_s
        super(message)
      end
    end
  end
end
