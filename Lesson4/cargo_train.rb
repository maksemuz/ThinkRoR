require_relative 'train'
require_relative 'cargo_car'
class CargoTrain < Train
  def carriage_class
    CargoCarriage
  end
end