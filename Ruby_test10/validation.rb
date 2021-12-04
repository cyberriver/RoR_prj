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
#SOLUTION 2 NOT WORKING
    #  self.instance_variables.each do |var|
    #    puts"instance var #{var}"
      #  var_key = eval(var.to_sym)
    #    self.class.validate_data.each do |hash|
    #      puts "log: hash = #{hash}"
    #      if hash.key(var)
        #  if hash.has_key? 'var'
    #      run_data.push(hash[var])
    #      end
    #      puts "log: run_data=#{run_data}"
    #    end

    #  end
    end
    #=== SOLUTION 1
    #  run_data=[]
    #  check=0
    #  self.class.validate_data.each do |hash|
    #    puts "log: hash = #{hash}"
    #    puts "var = #{var.to_sym}"
    #    puts "hash[:name] #{hash[:name]}"

    #    if hash[:name]==var.to_sym
    #      run_data.push(hash)
    #    end
      #  hash.each do |key,value|
      #    puts "log: key= #{key}, value= #{value}"
      #    puts "#{check}run_data #{run_data}"
      #    if key=var.to_sym
      #      then run_data.push(hash)
      #  end
      #  check +=1
      #  puts "#{check}run_data #{run_data}"
      #end
    #  puts "log: run_data=#{run_data}"
    #  end
    #

    #  run_data.each do |hash|
    #      validate_choose(hash,var)
    #  end

  #  rescue StandardError => e
  #    puts e.inspect
  #    puts e.backtrace.inspect

  #  end

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
