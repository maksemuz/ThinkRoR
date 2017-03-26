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
      puts '------------------------------------------------'
      options.values.each_with_index { |line, index| puts "#{index}:\t#{line}" }
      print '> '
      send options.keys[gets.strip.to_i]
    end
  end

  # - Создавать станции
  def add_station
    name = nil
    print 'Имя станции (до 10 символов): '
    name = gets.strip
    Station.new(name)
  rescue => err_msg
    puts err_msg
    retry
  end

  # - Создавать поезда
  def add_train
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

  # - Создавать маршруты
  def add_route
    name = nil
    print 'Имя маршрута: '
    name = gets.strip
    print 'Первая станция: '
    start = Station.all[gets.strip]
    raise ArgumentError, 'Такой станции нет.' unless Station.all.value? start
    print 'Последняя станция: '
    finish = Station.all[gets.strip]
    raise ArgumentError, 'Такой станции нет.' unless Station.all.value? finish
    Route.new(name, start, finish)
  rescue => err_msg
    puts err_msg
    retry
  end

  # - Добавить станцию в маршрут
  def insert_station
    print 'Имя маршрута: '
    rt_name = gets.strip
    puts 'Такого маршрута нет.' unless Route.all.key? rt_name
    print 'Имя станции: '
    st_name = gets.strip
    puts 'Такой станции нет.' unless Station.all.key? st_name
    print 'Позиция станции в маршруте: '
    position = gets.strip
    route = Route.all[rt_name]
    route.add_station(st_name, position)
  end

  # - Удалить станцию из маршрута
  def remove_station
    print 'Имя маршрута: '
    rt_name = gets.strip
    puts 'Такого маршрута нет.' unless Route.all.key? rt_name
    print 'Имя станции: '
    st_name = gets.strip
    puts 'Такой станции нет.' unless Station.all.key? st_name
    route = Route.all[rt_name]
    route.del_station_by_name(st_name)
  end

  # - Назначать маршрут поезду
  def assign_route
    print 'Имя маршрута: '
    rt_name = gets.strip
    puts 'Такого маршрута нет.' unless Route.all.key? rt_name
    print 'Номер поезда: '
    number = gets.strip
    puts 'Такого поезда нет.' unless Train.all.key? number
    train = Train.all[number]
    route = Route.all[rt_name]
    train.add_route(route)
  end

  # - Добавлять вагоны к поезду
  def add_carriage
    print 'Номер поезда: '
    number = gets.strip
    puts 'Такого поезда нет.' unless Train.all.key? number
    train = Train.all[number]
    if train.is_a? CargoTrain
      print 'Введите объем вагона (по умолчанию 1000): '
      carriage = CargoCarriage.new(gets.to_f)
    elsif train.is_a? PassengerTrain
      print 'Введите количество мест в вагоне (по умолчанию 50): '
      carriage = PassengerCarriage.new(gets.to_i)
    end
    train.plus_car(carriage)
  end

  # - Занять место в вагоне
  def reserve
    print 'Номер поезда: '
    number = gets.strip
    puts 'Такого поезда нет.' unless Train.all.key? number
    train = Train.all[number]
    print 'Номер вагона: '
    car_num = gets.strip.to_i - 1
    puts 'Такого вагона нет' unless train.carriages[car_num]
    if train.is_a? CargoTrain
      print 'Введите объем резерва: '
      vol = gets.strip.to_f
    elsif train.is_a? PassengerTrain
      print 'Введите количество мест: '
      vol = gets.strip.to_i
    end
    train.carriages[car_num].reserve(vol)
  end

  # - Отцеплять вагоны от поезда
  def rem_carriage
    print 'Номер поезда: '
    number = gets.strip
    puts 'Такого поезда нет.' unless Train.all.key? number
    train = Train.all[number]
    train.minus_car
  end

  # - Переместить поезд вперед по маршруту
  def train_forward
    print 'Номер поезда: '
    number = gets.strip
    puts 'Такого поезда нет.' unless Train.all.key? number
    train = Train.all[number]
    train.move_forward
  end

  # - Переместить поезд назад по маршруту
  def train_back
    print 'Номер поезда: '
    number = gets.strip
    puts 'Такого поезда нет.' unless Train.all.key? number
    train = Train.all[number]
    train.move_back
  end

  # - Просматривать список станций
  def all_stations
    puts Station.all.keys
  end

  # - Просматривать список маршрутов
  def all_routes
    puts Route.all.keys
  end

  # - Просматривать список поездов
  def all_trains
    puts Train.all.keys
  end

  # - Автоматическая генерация тестовых объектов
  def autogen
    puts 'Сгенерено 2 станции, 2 маршрута, 4 поезда, в каждом по 5 вагонов'
    1.upto(2) do |count|
      Station.new("Station#{count}")
    end
    1.upto(2) do |count|
      Route.new("Route#{count}",
                Station.all["Station#{count * 2 - count}"],
                Station.all["Station#{count + 4}"])
    end
    1.upto(2) do |count|
      [CargoTrain, PassengerTrain].each_with_index do |klass, index|
        train = klass.new("TR#{index}-0#{count}")
        train.add_route(Route.all["Route#{count}"])
        1.upto(5) { train.plus_car(train.carriage_class.new) }
      end
    end

  end

  def train_process
    Proc.new do |num, car|
      puts "\t#{num + 1}\t #{car.class},\tfree: #{car.free},\treserved: #{car.busy}"
    end
  end

  def station_process
    Proc.new do |train|
      puts "\t#{train.number},\t#{train.class},\t#{train.carriages.size}"
    end
  end

  # - Отображение вагонов поезда
  def train_info
    number = nil
    print 'Номер поезда: '
    number = gets.strip
    raise ArgumentError, 'Такого поезда нет' unless Train.all.key? number
    train = Train.all[number]
    train.proc_carriages(train_process)
  rescue => err_msg
    puts err_msg
    retry
  end

  # - Просматривать список поездов на станции
  def station_info
    name = ''
    print 'Имя станции: '
    name = gets.strip
    raise ArgumentError, 'Такой станции нет.' unless Station.all.key? name
    station = Station.all[name]
    station.proc_trains(station_process)
  rescue => err_msg
    puts err_msg
    retry
  end

  def quit
    exit
  end
end
