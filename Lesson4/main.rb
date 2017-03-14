require_relative 'station'
require_relative 'route'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_car'
require_relative 'passenger_car'

@options = [
    {quit: 'Выход'},
    {add_station: 'Создать станцию'},
    {add_train: 'Создать поезд'},
    {add_route: 'Создать маршрут'},
    {insert_station: 'Добавить станцию в маршрут'},
    {remove_station: 'Удалить станцию из маршрута'},
    {assign_route: 'Назначать маршрут поезду'},
    {add_car: 'Добавить вагон к поезду'},
    {rem_car: 'Отцепить вагон от поезда'},
    {train_forward: 'Переместить поезд вперед по маршруту'},
    {train_back: 'Переместить поезд назад по маршруту'},
    {all_stations: 'Посмотреть список станций'},
    {all_routes: 'Посмотреть список маршрутов'},
    {all_trains: 'Посмотреть список поездов'},
    {trains_by_station: 'Посмотреть список поездов на станции'}
]

# - Создавать станции
def add_station
  print 'Имя станции: '
  name = gets.strip
  raise ArgumentError 'Такая станция уже есть.' if Station.all_names.include? name
  Station.new(name)
end

# - Создавать поезда
def add_train
  print 'Тип поезда (cargo или passenger): '
  type = gets.strip
  print 'Номер поезда: '
  number = gets.strip
  raise ArgumentError 'Такой поезд уже есть.' if Train.all_numbers.include? number
  case type
    when 'cargo'
      Cargotrain.new(number)
    when 'passenger'
      Passengertrain.new(number)
  end
end

# - Создавать маршруты
def add_route
  print 'Имя маршрута: '
  name = gets.strip
  raise ArgumentError 'Такой маршрут уже есть.' if Route.all_names.include? name
  print 'Первая станция: '
  start = gets.strip
  raise ArgumentError 'Такой станции нет.' unless Station.all_names.include? start
  print 'Последняя станция: '
  finish = gets.strip
  raise ArgumentError 'Такой станции нет.' unless Station.all_names.include? finish
  Route.new(name, start, finish)
end

# - Добавить станцию в маршрут
def insert_station
  print 'Имя маршрута: '
  rt_name = gets.strip
  raise ArgumentError 'Такого маршрута нет.' unless Route.all_names.include? rt_name
  print 'Имя станции: '
  st_name = gets.strip
  raise ArgumentError 'Такой станции нет.' unless Station.all_names.include? st_name
  print 'Позиция станции в маршруте: '
  position = gets.strip
  route = Route.all_routes.find { |rt| rt.name == rt_name }
  route.add_station(st_name, position)
end

# - Удалить станцию из маршрута
def remove_station
  print 'Имя маршрута: '
  rt_name = gets.strip
  raise ArgumentError 'Такого маршрута нет.' unless Route.all_names.include? rt_name
  print 'Имя станции: '
  st_name = gets.strip
  raise ArgumentError 'Такой станции нет.' unless Station.all_names.include? st_name
  route = Route.all_routes.find { |rt| rt.name == rt_name }
  route.del_station_by_name(st_name)
end

# - Назначать маршрут поезду
def assign_route
  print 'Имя маршрута: '
  rt_name = gets.strip
  raise ArgumentError 'Такого маршрута нет.' unless Route.all_names.include? rt_name
  print 'Номер поезда: '
  number = gets.strip
  raise ArgumentError 'Такого поезда нет.' unless Train.all_numbers.include? number
  train = Train.all_trains.find { |tr| tr.number == number }
  route = Route.all_routes.find { |rt| rt.name == rt_name }
  train.add_route(route)
end

# - Добавлять вагоны к поезду
def add_car
  print 'Номер поезда: '
  number = gets.strip
  raise ArgumentError 'Такого поезда нет.' unless Train.all_numbers.include? number
  train = Train.all_trains.find { |tr| tr.number == number }
  case train.class
    when Cargotrain
      car = Cargocar.new
    when Passengertrain
      car = Passengercar.new
  end
  train.plus_car(car)
end

# - Отцеплять вагоны от поезда
def rem_car
  print 'Номер поезда: '
  number = gets.strip
  raise ArgumentError 'Такого поезда нет.' unless Train.all_numbers.include? number
  train = Train.all_trains.find { |tr| tr.number == number }
  train.minus_car
end

# - Переместить поезд вперед по маршруту
def train_forward
  print 'Номер поезда: '
  number = gets.strip
  raise ArgumentError 'Такого поезда нет.' unless Train.all_numbers.include? number
  train = Train.all_trains.find { |tr| tr.number == number }
  train.move_forward
end

# - Переместить поезд назад по маршруту
def train_back
  print 'Номер поезда: '
  number = gets.strip
  raise ArgumentError 'Такого поезда нет.' unless Train.all_numbers.include? number
  train = Train.all_trains.find { |tr| tr.number == number }
  train.move_back
end

# - Просматривать список станций
def all_stations
  puts Station.all_names
end

# - Просматривать список маршрутов
def all_routes
  puts Route.all_names
end

# - Просматривать список поездов
def all_trains
  puts Train.all_numbers
end

# - Просматривать список поездов на станции
def trains_by_station
  print 'Имя станции: '
  name = gets.strip
  raise ArgumentError 'Такой станции нет.' if Station.all_names.include? name
  station = Station.all.map { |st| st.name == name }
  puts station.trains
end

def quit
  exit
end

def main_menu
  loop do
    @options.each_with_index { |obj,index | puts "#{index}:\t#{obj.values}" }
    print "> "
    send (@options[gets.strip.to_i].keys.first)

  end
end

main_menu