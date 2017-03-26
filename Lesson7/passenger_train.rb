require_relative 'train'
require_relative 'passenger_car'
class PassengerTrain < Train

  def carriage_class
    PassengerCarriage
  end

end
