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

  def departure(train)
    @trains_in_station.delete(train)
  end

  def show_all
    puts "Станция \"#{@name}\""
    @trains_in_station.each { |train| puts "#{train.number}\t#{train.type}\t#{train.n_cars}" }
  end

  def show_by_type(type)
    puts "Станция \"#{@name}\", тип #{type}"
    @trains_in_station.each { |train| puts "#{train.number}\t#{train.type}\t#{train.n_cars}" if train.type == type}
  end
end

