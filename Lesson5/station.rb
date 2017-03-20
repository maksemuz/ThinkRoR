# Имеет название, которое указывается при ее создании
# Может принимать поезда (по одному за раз)
# Может показывать список всех поездов на станции, находящиеся в текущий момент
# Может показывать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).

require_relative 'instance_counter'

class Station
  include InstanceCounter
  attr_accessor :name, :trains

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
  end

  def arrive(train)
    @trains << train
  end

  def departure(train)
    @trains.delete(train)
  end

  def show_by_type(type)
    @trains.map { |train| train if train.type == type }.size
  end

  def self.all
    @@stations
  end

  def self.names
    @@stations.map { |station| station.name}
  end

end
