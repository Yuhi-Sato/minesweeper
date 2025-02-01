module Domains
  module Validators
    class Base
      attr_reader :object, :errors
      def initialize(domain_object)
        @object = domain_object
        @errors = Errors.new
      end
    end

    class Errors
      def initialize
        @errors = []
      end

      def add(message)
        @errors << message
      end

      def empty?
        @errors.empty?
      end

      def full_messages
        @errors.join(", ")
      end
    end

    class Error < StandardError
      def initialize(errors)
        @errors = errors
        message = errors.is_a?(Array) ? errors.join(", ") : errors.to_s
        super(message)
      end
    end
  end
end
