require_relative  'trains.rb'
class Cargo_train < Train
  def initialize (num)
    super
    @train_type = 1
    @volume = 100
    @train_type_name = "грузовой"
  end
end
#
