# this class for Cargo train
# frozen_string_literal: true

require_relative 'trains'
class CargoTrain < Train
  def initialize(num)
    super
    @train_type = 2
    @train_type_name = 'грузовой'
  end
end
