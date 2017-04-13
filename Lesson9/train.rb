require_relative 'company'
require_relative 'validation'
require_relative 'instance_counter'

class Train
  include Company
  include Validation
  include InstanceCounter

  attr_accessor :train_number, :speed

  NUMBER_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/i

  validate :number, :presence
  validate :number, :existance
  validate :number, :format, NUMBER_FORMAT

  @@trains = {}

  def initialize(number)
    @number = number
    puts "NUMBER =====   #{@number}, #{@number.class}"
    validate!
    @speed = 0
    @carriages = []
    @@trains[number] = self
    register_instance
  end

  def self.all
    @@trains
  end

  def self.find(number)
    @@trains[number]
  end

  def faster
    @speed += 1
  end

  def slower
    @speed -= 1
  end

  def minus_car
    speed_zero?
    if @carriages.empty?
      raise ArgumentError, 'В составе 0 вагонов, отцеплять нечего.'
    end
    @carriages.drop(1)
  end

  def plus_car(car)
    speed_zero?
    raise ArgumentError, "Неверный класс вагона - #{car.class}" unless car.is_a? carriage_class
    @carriages << car
  end

  def add_route(route)
    if @current_st_index
      raise ArgumentError, 'Поезд находится на маршруте, нельзя назначить новый маршрут.'
    end
    @route = route
    @current_st_index = 0
    @route.stations[@current_st_index].arrive(self)
  end

  def move_forward
    if @current_st_index == @route.stations.size - 1
      raise ArgumentError, 'Конец маршрута, вперед движения нет.'
    end
    @route.stations[@current_st_index].departure(self)
    @current_st_index += 1
    @route.stations[@current_st_index].arrive(self)
  end

  def move_back
    raise ArgumentError, 'Начало маршрута, назад движения нет.' if @current_st_index == 0
    @route.stations[@current_st_index].departure(self)
    @current_st_index -= 1
    @route.stations[@current_st_index].arrive(self)
  end

  def previous_station
    @route.stations[@current_st_index - 1]
  end

  def current_station
    @route.stations[@current_st_index]
  end

  def next_station
    @route.stations[@current_st_index + 1]
  end

  attr_reader :carriages

  def process_carriages
    @carriages.each.with_index(1) { |car, index| yield(car, index) }
  end

  # методы в этой секции используются в пределах класса,
  # наследуются и переопределяются в наследниках
  private

  def carriage_class
    raise ArgumentError, 'Класс вагона не задан'
  end

  def speed_zero?
    if @speed != 0
      raise ArgumentError, 'Нельзя манипулировать вагонами на ходу, сначала остановите поезд.'
    end
    true
  end
end
