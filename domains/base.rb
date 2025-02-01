module Domains
  class Base
    class << self
      attr_accessor :validator_class

      def inherited(subclass)
        subclass_name = subclass.to_s.split('::').last
        validator_class_name = "::Domains::Validators::#{subclass_name}Validator"

        if Object.const_defined?(validator_class_name)
          validator_class = Object.const_get(validator_class_name)
        else
          validator_class = Validators::Base
        end

        subclass.validator_class = validator_class
      end

      def with_validation(*method_names)
        method_names.each do |method_name|
          method_name = method_name.to_sym if method_name.is_a?(String)

          unless method_defined?(method_name) || method_name == :initialize
            raise NotImplementedError, "#{self}##{method_name} must be implemented"
          end

          validate_method_name = "validate_#{method_name}!"
          unless validator_class.method_defined?(validate_method_name)
            raise NotImplementedError, "#{validator_class}##{validate_method_name} must be implemented"
          end

          class_eval do
            alias_method "original_#{method_name}", method_name

            define_method(method_name) do |*args, **kwargs, &block|
              validator = self.class.validator_class.new(self)
              validator.send(validate_method_name, *args, **kwargs)
              send("original_#{method_name}", *args, **kwargs, &block)
            end
          end
        end
      end
    end
  end
end
