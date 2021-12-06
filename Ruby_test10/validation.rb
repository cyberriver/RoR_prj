# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend(ClassMethods)
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name,type,*params)
      @@validate_data ||= []
      hash_data ||= {}
      hash_data[:name] = name.to_s
      hash_data[:validation_type] = type
      hash_data[:params] =params
      hash_data.each {|key,value| puts"hash_data; key: #{key}, value: #{value}"}
      @@validate_data.push(hash_data)
      puts "log: validate_data => #{@@validate_data}"
    end

    def validate_data
      return @@validate_data
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    def validate!
      run_data=[] #определяем проверки для каждой переменной
      self.class.validate_data.each do |hash|
        self.instance_variables.each do |obj_var|
        puts "obj_var = #{obj_var}"
        var = instance_variable_get(obj_var)
        puts "var = #{var}"
        send("validate_#{hash[:validation_type]}",var,hash[:params]) unless var==[]
        puts "log:validate!: #{hash[:validation_type]} - OK"
      end
      end
    end

    private

    def validate_presense(name,params)
      raise "can't be nil or empty" if name == '' || name.nil?
    end

    def validate_format(name, params)
      puts "validate_format:LOG name #{name}, params #{params}"
      str = params.inspect
      reg = Regexp.new(str)
      puts "reg: #{reg}"
      raise "invalid format #{name}, mask #{params}" unless name.to_s =~ reg
    end

    def validate_type_check(name,params)
      raise "incorrect class - mismatch" unless name.is_a?(params)
    end
  end
end
