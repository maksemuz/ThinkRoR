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
    @route = []
    @current_station = nil
  end

  def faster
    @speed += 1
  end

  def slower
    @speed -= 1
  end

  def minus_car
    if @speed == 0
      @n_cars -= 1
    else
      raise ArgumentError, 'Нельзя манипулировать вагонами на ходу, сначала остановите поезд.'
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
    if @current_station.nil?
      @route = route
      @current_station = @route.list[0]
      @current_station.arrive(self)
    else
      raise ArgumentError, 'Поезд находится на маршруте, нельзя назначить новый маршрут.'
    end

  end

  def move_to(st_name)
    st_to_go = @route.list.find { |st| st.name == st_name}
    if @route.list.include?(st_to_go)
      @current_station.departure(self)
      @current_station = st_to_go
      @current_station.arrive(self)
    else
      raise ArgumentError, "Станции \"#{st_to_go.name}\" нет в маршрутном листе."
    end
  end

  def show_prev_st
    cur_index = @route.list.index(@current_station)
    @route.list[cur_index - 1].name
  end

  def show_cur_st
    @current_station.name
  end

  def show_next_st
    cur_index = @route.list.index(@current_station)
    @route.list[cur_index + 1].name
  end

end