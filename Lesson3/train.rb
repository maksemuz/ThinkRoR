#  - Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов,
# эти данные указываются при создании экземпляра класса
#  - Может набирать скорость
#  - Может показывать текущую скорость
#  - Может тормозить (сбрасывать скорость до нуля)
#  - Может показывать количество вагонов
#  - Может прицеплять/отцеплять вагоны (по одному вагону за операцию,
# метод просто увеличивает или уменьшает количество вагонов).
# Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
#  - Может принимать маршрут следования (объект класса Route)
#  - Может перемещаться между станциями, указанными в маршруте.
#  - Показывать предыдущую станцию, текущую, следующую, на основе маршрута

class Train
  attr_accessor :number, :type, :n_cars, :speed

  def initialize(number, type, n_cars)
    @number = number
    @type = type
    @n_cars = n_cars
    @speed = 0
    @route
    @current_st_index
  end

  def faster
    @speed += 1
  end

  def slower
    @speed -= 1
  end

  def minus_car
    raise ArgumentError, 'Нельзя манипулировать вагонами на ходу, сначала остановите поезд.' if @speed != 0
    raise ArgumentError, 'В составе 0 вагонов, оцеплять нечего.' if @n_cars == 0
    @n_cars -= 1 if @speed == 0 && @n_cars > 0
  end

  def plus_car
    raise ArgumentError, 'Нельзя манипулировать вагонами на ходу, сначала остановите поезд.' if @speed != 0
    @n_cars += 1
  end

  def set_route(route)
    raise ArgumentError, 'Поезд находится на маршруте, нельзя назначить новый маршрут.' if @current_st_index
    @route = route
    @current_st_id = 0
    @route.stations[@current_st_index].arrive(self)
  end

  def move_forward
    raise ArgumentError, 'Конец маршрута, вперед движения нет.' if @current_st_index == @route.stations.size - 1
    @route.stations[@current_st_index].departure(self)
    @current_st_index += 1
    @route.stations[@current_st_index].arrive(self)
  end

  def move_back
    raise ArgumentError, 'Начало маршрута, назад движения нет.' if @current_st_index == 0
    @route.stations[@current_st_index].departure(self)
    @current_st_index -= 1
    @route.stations[@current_st_index].arrive(self)
  end

  def previous_station
    @route.stations[@current_st_index - 1]
  end

  def current_station
    @route.stations[@current_st_index]
  end

  def next_station
    @route.stations[@current_st_index + 1]
  end

end