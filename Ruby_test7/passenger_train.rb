require_relative  'trains.rb'
class Passenger_train < Train
  def initialize (num)
    super
    @train_type = 1
    @train_type_name = "пассажирский"
  end
end
