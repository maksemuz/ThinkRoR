# Имеет название, которое указывается при ее создании
# Может принимать поезда (по одному за раз)
# Может показывать список всех поездов на станции, находящиеся в текущий момент
# Может показывать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# Может отправлять поезда (по одному за раз, при этом,
# поезд удаляется из списка поездов, находящихся на станции).

require_relative 'instance_counter'
require_relative 'validation'

class Station
  include InstanceCounter
  include Validation
  attr_accessor :name, :trains

  NAME_FORMAT = /^[a-z\d]{,8}$/i

  validate :name, :presence
  validate :name, :existance
  validate :name, :format, NAME_FORMAT

  @@stations = {}

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations[name] = self
    register_instance
  end

  def self.all
    @@stations
  end

  def arrive(train)
    @trains << train
  end

  def departure(train)
    @trains.delete(train)
  end

  def show_trains_by_type(type)
    @trains.select { |train| train if train.type == type }
  end

  def process_trains
    @trains.each { |train| yield(train) }
  end
end
