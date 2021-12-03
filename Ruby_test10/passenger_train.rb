# class for passenger trains
# frozen_string_literal: true

require_relative 'trains'
class PassengerTrain < Train
  def initialize(num)
    super
    @train_type = 1
    @train_type_name = 'пассажирский'
  end
end
#
