module Accessors
  def attr_accessor_with_history(*methods)
    methods.each do |method|
      method_name = "#{method}".to_sym
      define_method(method) {instance_variable_get(method_name)}
      define_method("#{method}=".to_sym) { |value| instance_variable_set(method_name, value) }
    end
  end

#который возвращает массив всех значений данной переменной.

  def strong_attr_accessor
    return 1
  end
end
