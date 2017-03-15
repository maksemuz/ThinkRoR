Encoding.default_external = 'UTF-8'

require_relative 'car'
require_relative 'station'
require_relative 'route'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_car'
require_relative 'passenger_car'

class Interface
  def initialize
    @stations = []
    @station_names = []
    @routes = []
    @route_names = []
    @trains = []
    @train_numbers = []
  end

  def menu(options)
    loop do
      options.each_with_index { |obj, index| puts "#{index}:\t#{obj.values}" }
      print '> '
      send options[gets.strip.to_i].keys.first
    end
  end

  # - Создавать станции
  def add_station
    print 'Имя станции: '
    name = gets.strip
    puts 'Такая станция уже есть.' if @station_names.include? name
    @stations << Station.new(name)
    @station_names << name
  end

  # - Создавать поезда
  def add_train
    print 'Тип поезда (cargo или passenger): '
    type = gets.strip
    print 'Номер поезда: '
    number = gets.strip
    puts 'Такой поезд уже есть.' if @train_numbers.include? number
    case type
    when 'cargo'
      @trains << CargoTrain.new(number)
    when 'passenger'
      @trains << PassengerTrain.new(number)
    else
      puts 'Неверный тип поезда'
    end
    @train_numbers << number
  end

  # - Создавать маршруты
  def add_route
    print 'Имя маршрута: '
    name = gets.strip
    puts 'Такой маршрут уже есть.' if @route_names.include? name
    print 'Первая станция: '
    start = gets.strip
    puts 'Такой станции нет.' unless @station_names.include? start
    print 'Последняя станция: '
    finish = gets.strip
    puts 'Такой станции нет.' unless @station_names.include? finish
    @routes << Route.new(name, start, finish)
    @route_names << name
  end

  # - Добавить станцию в маршрут
  def insert_station
    print 'Имя маршрута: '
    rt_name = gets.strip
    puts 'Такого маршрута нет.' unless @route_names.include? rt_name
    print 'Имя станции: '
    st_name = gets.strip
    puts 'Такой станции нет.' unless @station_names.include? st_name
    print 'Позиция станции в маршруте: '
    position = gets.strip
    route = @routes.find { |rt| rt.name == rt_name }
    route.add_station(st_name, position)
  end

  # - Удалить станцию из маршрута
  def remove_station
    print 'Имя маршрута: '
    rt_name = gets.strip
    puts 'Такого маршрута нет.' unless @route_names.include? rt_name
    print 'Имя станции: '
    st_name = gets.strip
    puts 'Такой станции нет.' unless @station_names.include? st_name
    route = @routes.find { |rt| rt.name == rt_name }
    route.del_station_by_name(st_name)
  end

  # - Назначать маршрут поезду
  def assign_route
    print 'Имя маршрута: '
    rt_name = gets.strip
    puts 'Такого маршрута нет.' unless @route_names.include? rt_name
    print 'Номер поезда: '
    number = gets.strip
    puts 'Такого поезда нет.' unless @train_numbers.include? number
    train = @trains.find { |tr| tr.number == number }
    route = @routes.find { |rt| rt.name == rt_name }
    train.add_route(route)
  end

  # - Добавлять вагоны к поезду
  def add_carriage
    print 'Номер поезда: '
    number = gets.strip
    puts 'Такого поезда нет.' unless @train_numbers.include? number
    train = @trains.find { |tr| tr.number == number }
    puts train
    puts train.inspect
    if train.is_a? CargoTrain
      carriage = CargoCarriage.new
    elsif train.is_a? PassengerTrain
      carriage = PassengerCarriage.new
    end
    puts carriage.class
    train.plus_car(carriage)
  end

  # - Отцеплять вагоны от поезда
  def rem_carriage
    print 'Номер поезда: '
    number = gets.strip
    puts 'Такого поезда нет.' unless @train_numbers.include? number
    train = @trains.find { |tr| tr.number == number }
    train.minus_car
  end

  # - Переместить поезд вперед по маршруту
  def train_forward
    print 'Номер поезда: '
    number = gets.strip
    puts 'Такого поезда нет.' unless @train_numbers.include? number
    train = @trains.find { |tr| tr.number == number }
    train.move_forward
  end

  # - Переместить поезд назад по маршруту
  def train_back
    print 'Номер поезда: '
    number = gets.strip
    puts 'Такого поезда нет.' unless @train_numbers.include? number
    train = @trains.find { |tr| tr.number == number }
    train.move_back
  end

  # - Просматривать список станций
  def all_stations
    puts @station_names
  end

  # - Просматривать список маршрутов
  def all_routes
    puts @route_names
  end

  # - Просматривать список поездов
  def all_trains
    puts @trains
  end

  # - Просматривать список поездов на станции
  def trains_by_station
    print 'Имя станции: '
    name = gets.strip
    puts 'Такой станции нет.' if @station_names.include? name
    station = @stations.map { |st| st.name == name }
    puts station.trains
  end

  def quit
    exit
  end
end
