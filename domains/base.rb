# frozen_string_literal: true

module Domains
  class Base
    def self.inherited(subclass)
      subclass.extend(ClassMethods)
      define_validator_class(subclass)
    end

    module ClassMethods
      def validator_class
        @validator_class
      end

      def with_validation(*method_names)
        method_names.each do |method_name|
          unless method_defined?(method_name) || private_method_defined?(method_name)
            raise NotImplementedError, "#{self}##{method_name} must be implemented"
          end

          validate_method_name = "validate_#{method_name}!"
          unless validator_class.method_defined?(validate_method_name)
            raise NotImplementedError, "#{validator_class}##{validate_method_name} must be implemented"
          end

          # NOTE: 元のメソッドをラップする
          alias_method "original_#{method_name}", method_name

          define_method(method_name) do |*args, **kwargs, &block|
            validator = self.class.validator_class.new(self)
            validator.send(validate_method_name, *args, **kwargs)
            send("original_#{method_name}", *args, **kwargs, &block)
          end
        end
      end
    end

    def self.define_validator_class(subclass)
      subclass_name = subclass.to_s.split('::').last
      validator_class_name = "::Domains::Validators::#{subclass_name}Validator"

      validator_class = if Domains::Validators.const_defined?(validator_class_name)
                          Domains::Validators.const_get(validator_class_name)
                        else
                          Domains::Validators::Base
                        end

      # NOTE: サブクラスのクラスインスタンス変数にバリデータクラスをセット
      subclass.instance_variable_set('@validator_class', validator_class)
    end
  end
end
