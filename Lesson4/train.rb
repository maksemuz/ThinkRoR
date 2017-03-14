class Train
  attr_accessor :number, :speed, :all
  @@all = []

  def initialize(number)
    @number = number
    @speed = 0
    @route
    @current_st_index
    @cars = []
    @@all << self
  end

  def faster
    @speed += 1
  end

  def slower
    @speed -= 1
  end

  def minus_car
    raise ArgumentError, 'Нельзя манипулировать вагонами на ходу, сначала остановите поезд.' if @speed != 0
    raise ArgumentError, 'В составе 0 вагонов, оцеплять нечего.' if @cars.empty?
    @cars.drop(1) if @speed == 0 && !@cars.empty?
  end

  def plus_car(car)
    raise ArgumentError, 'Нельзя манипулировать вагонами на ходу, сначала остановите поезд.' if @speed != 0
    @cars << car
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

  def self.all_numbers
    @@all.map { |tr| tr.number }
  end

end