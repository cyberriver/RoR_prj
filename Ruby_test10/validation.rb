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
      params.each do |value|
        if value.is_a?(Regexp)
          hash_data[:reg]=value
        elsif hash_data[:validation_type] == :type
          hash_data[:klass]=value
        else
        hash_data[value.to_sym]=value
      end
      end
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
        var = instance_variable_get("@#{hash[:name]}")
        puts "var = > #{var}"
        validate_choose(hash,var)
      end
    end

    def validate_choose(hash,name)
      case hash[:validation_type]
      when :presense then validate_presense(name)
      when :format then validate_format(name, hash[:reg])
      when :type then validate_type_check(name, hash[:klass])
      else return
      end
      puts "log: #{hash[:validation_type]} OK"
    rescue StandardError => e
      puts e.inspect
      puts "log: #{hash[:validation_type]} not OK"
    end

    private

    def validate_presense(name)
      raise "can't be nil or empty" if name == '' || name.nil?
    end

    def validate_format(name, reg)
      raise 'invalid format' unless name =~ reg
    end

    def validate_type_check(name,klass)
      raise 'incorrect class - mismatch' unless name.is_a?(klass)
    end
  end
end
