require_relative  'trains.rb'
class Passenger_train < Train

  attr_reader :busy_place, :free_place
#  @block = Proc.new { |x, y| x -=1; y+=1}
  def initialize (num,&place)
    super
    @free_place = place
    @busy_place = 0
    @train_type = 2
    @train_type_name = "пассажирский"
  end

  def sit_down
    @free_place -=1
    @busy_place +=1
  end

end
