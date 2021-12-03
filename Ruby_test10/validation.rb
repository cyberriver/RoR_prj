# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend(ClassMethods)
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, validation_type, *options)
      case validation_type.to_sym
      when :presense then presense(name)
      when :format then format(name, options[1])
      when :type then type_check(name, options[1])
      else return
      end
      puts 'everything OK'
    rescue StandardError => e
      puts e.inspect
    end

    private

    def presense(name)
      raise "can't be nil or empty" if name == '' || name.nil?
    end

    def format(name, reg)
      raise 'invalid format' unless name =~ reg
    end

    def type_check(_name)
      raise 'incorrect class - mismatch' unless value.is_a?(klass)
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    def validate!(name, validation_type, *options)
      self.class.validate(name, validation_type, *options)
    rescue StandardError => e
      puts e.inspect
    end
  end
end
