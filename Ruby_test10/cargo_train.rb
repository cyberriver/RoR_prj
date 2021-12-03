# this class for Cargo train
# frozen_string_literal: true

$LOAD_PATH << '.'
require 'instance_counter'
require 'accessors'

require_relative 'trains'
class CargoTrain < Train
  include Accessors
  attr_accessor_with_history :a, :b, :c
  strong_attr_accessor :a1, String

  def initialize(num)
    super
    @train_type = 2
    @train_type_name = 'грузовой'
  end
end
