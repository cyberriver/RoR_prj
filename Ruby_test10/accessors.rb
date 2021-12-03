# frozen_string_literal: true

module Accessors
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def attr_accessor_with_history(*methods)
      methods.each do |method|
        method_name = "@#{method}".to_sym
        hist = "@#{method}_history".to_sym
        define_method(method) { instance_variable_get(method_name) }
        define_method("#{method}_history") { instance_variable_get(hist).each { |value| puts value } }
        define_method("#{method}=".to_sym) do |value|
          instance_variable_set(method_name, value)
          history_values = instance_variable_get(hist) || []
          instance_variable_set(hist, history_values << value)
        end
      end
    end

    def strong_attr_accessor(attr_name, klass)
      method_name = "@#{attr_name}".to_sym
      define_method(attr_name) { instance_variable_get(method_name) }
      define_method("#{attr_name}=") do |value|
        raise TypeError 'Вы указали некорректный тип' unless value.is_a?(klass)

        instance_variable_set(method_name, value)
      end
    end
  end
end
