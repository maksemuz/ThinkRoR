require_relative 'car'
require_relative 'station'
require_relative 'route'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_car'
require_relative 'passenger_car'

class Interface
  def initialize
  end

  def menu(options)
    loop do
      options.values.each_with_index { |line, index| puts "#{index}:\t#{line}" }
      print '> '
      send options.keys[gets.strip.to_i]
    end
  end

  # - Создавать станции
  def add_station
    begin
      name = nil
      print 'Имя станции (до 10 символов): '
      name = gets.strip
      Station.new(name)
    rescue => err_msg
      puts err_msg
      retry
    end

  end

  # - Создавать поезда
  def add_train
    begin
      print 'Тип поезда (cargo или passenger): '
      type = gets.strip
      number = nil
      print 'Номер поезда: '
      number = gets.strip
      case type
        when 'cargo'
          CargoTrain.new(number)
        when 'passenger'
          PassengerTrain.new(number)
        else
          raise ArgumentError, 'Неверный тип поезда'
      end
    rescue => err_msg
      puts err_msg
      retry
    end
  end

  # - Создавать маршруты
  def add_route
    begin
      name = nil
      print 'Имя маршрута: '
      name = gets.strip
      print 'Первая станция: '
      start = gets.strip
      raise ArgumentError, 'Такой станции нет.' unless Station.names.include? start
      print 'Последняя станция: '
      finish = gets.strip
      raise ArgumentError, 'Такой станции нет.' unless Station.names.include? finish
      Route.new(name, start, finish)
    rescue => err_msg
      puts err_msg
      retry
    end
  end

  # - Добавить станцию в маршрут
  def insert_station
    print 'Имя маршрута: '
    rt_name = gets.strip
    puts 'Такого маршрута нет.' unless Route.names.include? rt_name
    print 'Имя станции: '
    st_name = gets.strip
    puts 'Такой станции нет.' unless Station.names.include? st_name
    print 'Позиция станции в маршруте: '
    position = gets.strip
    route = Route.all[rt_name]
    route.add_station(st_name, position)
  end

  # - Удалить станцию из маршрута
  def remove_station
    print 'Имя маршрута: '
    rt_name = gets.strip
    puts 'Такого маршрута нет.' unless Route.names.include? rt_name
    print 'Имя станции: '
    st_name = gets.strip
    puts 'Такой станции нет.' unless Station.names.include? st_name
    route = Route.all[rt_name]
    route.del_station_by_name(st_name)
  end

  # - Назначать маршрут поезду
  def assign_route
    print 'Имя маршрута: '
    rt_name = gets.strip
    puts 'Такого маршрута нет.' unless Route.names.include? rt_name
    print 'Номер поезда: '
    number = gets.strip
    puts 'Такого поезда нет.' unless Train.numbers.include? number
    train = Train.all[number]
    route = Route.all[rt_name]
    train.add_route(route)
  end

  # - Добавлять вагоны к поезду
  def add_carriage
    print 'Номер поезда: '
    number = gets.strip
    puts 'Такого поезда нет.' unless Train.numbers.include? number
    train = Train.all[number]
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
    puts 'Такого поезда нет.' unless Train.numbers.include? number
    train = Train.all[number]
    train.minus_car
  end

  # - Переместить поезд вперед по маршруту
  def train_forward
    print 'Номер поезда: '
    number = gets.strip
    puts 'Такого поезда нет.' unless Train.numbers.include? number
    train = Train.all[number]
    train.move_forward
  end

  # - Переместить поезд назад по маршруту
  def train_back
    print 'Номер поезда: '
    number = gets.strip
    puts 'Такого поезда нет.' unless Train.numbers.include? number
    train = Train.all[number]
    train.move_back
  end

  # - Просматривать список станций
  def all_stations
    puts Station.names
  end

  # - Просматривать список маршрутов
  def all_routes
    puts Route.names
  end

  # - Просматривать список поездов
  def all_trains
    puts Train.numbers
  end

  # - Просматривать список поездов на станции
  def trains_by_station
    print 'Имя станции: '
    name = gets.strip
    puts 'Такой станции нет.' if Station.names.include? name
    station = Station.all[name]
    puts station.trains
  end

  def quit
    exit
  end
end
