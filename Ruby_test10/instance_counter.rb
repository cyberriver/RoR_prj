# module for instances calculation
# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def instances
      @instances || 0
      puts @instances
    end

    def count
      @instances ||= 0
      @instances += 1
    end
  end

  module InstanceMethods
    private

    def register_instances
      self.class.count
    end
  end
end
#
