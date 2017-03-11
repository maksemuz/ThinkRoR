# Имеет название, которое указывается при ее создании
# Может принимать поезда (по одному за раз)
# Может показывать список всех поездов на станции, находящиеся в текущий момент
# Может показывать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).

class Station
  attr_accessor :name, :trains_in_station


  def initialize(name)
    @name = name
    @trains_in_station = []
  end

  def arrive(train)
    @trains_in_station << train
  end

  def departure(train_type)
    @trains_in_station.delete_at(@trains_in_station.index(train_type))
  end

  def show_all
    puts @trains_in_station
  end

  def show_by_type(type)
    puts "#{type}:\t #{@trains_in_station.select { |item| item == type }.size}"
  end
end

