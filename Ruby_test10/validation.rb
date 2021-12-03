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
      hash_data[:name] = name
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
      puts "log #{@@validate_data}"
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
      self.class.validate.validate_data each do |hash|
          validate_choose(hash)
        
      end
    rescue StandardError => e
      puts e.inspect
    end

    def validate_choose(hash)
      case hash[:validation_type]
      when :presense then validate_presense(hash[:name])
      when :format then validate_format(hash[:name], hash[:reg])
      when :type then validate_type_check(hash[:name], hash[:klass])
      else return
      end
      puts 'everything OK'
    rescue StandardError => e
      puts e.inspect
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
