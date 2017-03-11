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
  attr_accessor :number, :type, :n_cars

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

  def show_speed
    puts @speed
  end

  def show_cars
    puts @n_cars
  end

  def change_cars(value)
    if @speed == 0
      case value
        when '-'
          @n_cars -= 1
        when '+'
          @n_cars += 1
      end
    else
      puts 'Нельзя манипулировать вагонами на ходу, сначала остановите поезд.'
    end
  end

  def set_route(route)
    if @current_station.nil?
      @route = route
      @current_station = @route.list[0]
      @current_station.arrive(self)
    else
      puts 'Поезд находится на маршруте, нельзя назначить новый маршрут.'
    end

  end

  def move_to(st_name)
    st_to_go = @route.list.find { |st| st.name == st_name}
    if @route.list.include?(st_to_go)
      @current_station.departure(self)
      @current_station = st_to_go
      @current_station.arrive(self)
    else
      puts "Станции \"#{st_to_go.name}\" нет в маршрутном листе."
    end
  end

  def show_station(word)
    cur_index = @route.list.index(@current_station)
    case word
      when 'предыдущая'
        puts @route.list[cur_index - 1].name
      when 'текущая'
        puts @route.list[cur_index].name
      when 'следующая'
        puts @route.list[cur_index + 1].name
    end
  end

end