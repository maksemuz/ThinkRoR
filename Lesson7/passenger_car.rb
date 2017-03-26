require_relative 'car'
class PassengerCarriage < Carriage

  def initialize(places = 50)
    @places = places
    @free_places = places
    valid?(@places)
  end

  def reserve(vol)
    raise ArgumentError, "В вагоне нет #{vol} свободных мест, бронирование не удалось" \
    if @free_places - vol < 0
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

  def valid?(num)
    raise ArgumentError, 'Количество мест должно быть целым положительным числом' \
    if num.nil? || num <= 0 || !num.integer?
    true
  end

end
