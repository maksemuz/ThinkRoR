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
    @current_station
  end

  def faster
    @speed += 1
  end

  def slower
    @speed -= 1
  end

  def minus_car
    if @speed == 0 || @n_cars > 0
      @n_cars -= 1
    elsif @speed != 0
      raise ArgumentError, 'Нельзя манипулировать вагонами на ходу, сначала остановите поезд.'
    elsif @n_cars == 0
      raise ArgumentError, 'В составе 0 вагонов, оцеплять нечего.'
    end
  end

  def plus_car
    if @speed == 0
      @n_cars += 1
    else
      raise ArgumentError, 'Нельзя манипулировать вагонами на ходу, сначала остановите поезд.'
    end
  end

  def set_route(route)
    if @current_station
      raise ArgumentError, 'Поезд находится на маршруте, нельзя назначить новый маршрут.'
    else
      @route = route
      @current_station = 0
      @route.list[0].arrive(self)
    end

  end

  def move_to(st_name)
    st_to_go = @route.list.find_index { |st| st if st.name == st_name}
    puts st_to_go
    if st_to_go
      @route.list[@current_station].departure(self)
      @current_station = st_to_go
      @route.list[@current_station].arrive(self)
    else
      raise ArgumentError, "Станции \"#{st_name}\" нет в маршрутном листе."
    end
  end

  def previous_station
    @route.list[@current_station - 1]
  end

  def current_station
    @route.list[@current_station]
  end

  def next_station
    @route.list[@current_station + 1]
  end

end