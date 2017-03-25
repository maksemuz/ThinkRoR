require_relative 'company'

class Train
  include Company
  attr_accessor :number, :speed

  NUMBER_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/i

  @@trains = {}

  def initialize(number)
    @number = number
    valid?
    @speed = 0
    @carriages = []
    @@trains[number] = self

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
    raise ArgumentError, 'Нельзя манипулировать вагонами на ходу, сначала остановите поезд.' if @speed != 0
    raise ArgumentError, 'В составе 0 вагонов, отцеплять нечего.' if @carriages.empty?
    @carriages.drop(1) if @speed == 0 && !@carriages.empty?
  end

  def plus_car(car)
    raise ArgumentError, 'Нельзя манипулировать вагонами на ходу, сначала остановите поезд.' if @speed != 0
    raise ArgumentError, 'Неверный класс вагона' unless car.is_a? carriage_class
    @carriages << car
    puts @carriages
  end

  def add_route(route)
    raise ArgumentError, 'Поезд находится на маршруте, нельзя назначить новый маршрут.' if @current_st_index
    @route = route
    @current_st_index = 0
    @route.stations[@current_st_index].arrive(self)
  end

  def move_forward
    raise ArgumentError, 'Конец маршрута, вперед движения нет.' if @current_st_index == @route.stations.size - 1
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

  # методы в этой секции используются в пределах класса, наследуются и переопределяются в наследниках
  private

  def carriage_class
    raise ArgumentError, 'Класс вагона не задан'
  end

  protected

  def valid?
    raise ArgumentError, 'Номер не может быть пустым' if @number.empty?
    raise ArgumentError, 'Номер должен соответствовать заданному формату' if @number !~ NUMBER_FORMAT
    raise ArgumentError, 'Такой поезд уже есть.' if self.class.all.key? @number
    true
  end

end
