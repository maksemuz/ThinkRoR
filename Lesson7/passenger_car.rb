require_relative 'car'
class PassengerCarriage < Carriage

  def initialize(places = 50)
    @places = places
    @free_places = places
    validate!(@places)
  end

  def reserve(vol)
    if @free_places - vol < 0
      raise ArgumentError, "В вагоне нет #{vol} единиц свободного места, бронирование не удалось"
    end
    @free_places -= vol
  rescue => err
    puts err
  end

  def free
    @free_places
  end

  def busy
    @places - @free_places
  end

  private

  def validate!(num)
    unless num.is_a? Integer || num.positive?
      raise ArgumentError, 'Количество мест должно быть целым положительным числом'
    end
    true
  end

end
