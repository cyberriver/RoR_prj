require_relative  'trains.rb'
class Cargo_train < Train
  def initialize (num)
    super
    @train_type = 2
    @train_type_name = "грузовой"
  end
end
#
