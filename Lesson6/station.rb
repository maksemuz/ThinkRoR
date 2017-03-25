# Имеет название, которое указывается при ее создании
# Может принимать поезда (по одному за раз)
# Может показывать список всех поездов на станции, находящиеся в текущий момент
# Может показывать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).

require_relative 'instance_counter'

class Station
  include InstanceCounter
  attr_accessor :name, :trains

  NAME_FORMAT = /^[а-яА-Яa-zA-Z0-9]+$/

  @@stations = {}

  def initialize(name)
    @name = name
    valid?
    @trains = []
    @@stations[name] = self
    register_instance
  end

  def self.all
    @@stations
  end

  def self.names
    @@stations.keys
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

  protected

  def valid?
    raise ArgumentError, 'Имя не может быть пустым' if @name.empty?
    raise ArgumentError, 'Имя может содержать только буквы и цифры' if @name !~ NAME_FORMAT
    raise ArgumentError, 'Длина имени не более 10 символов' if @name.size > 10
    raise ArgumentError, 'Такая станция уже есть.' if self.class.names.include? @name
    true
  end

end
