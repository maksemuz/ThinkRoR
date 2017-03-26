require_relative 'car'
class CargoCarriage < Carriage

  def initialize(space = 1000)
    @space = space
    @free_space = space
    valid?(@space)
  end

  def reserve(vol)
    valid?(vol)
    raise ArgumentError, 'В вагоне нет свободного места, бронирование не удалось' \
    if @free_space - vol < 0
    @free_space -= vol
  end

  def free
    @free_space
  end

  def busy
    @space - @free_space
  end

  private

  def valid?(num)
    raise ArgumentError, "Объем #{num} должен быть положительным числом" \
    if (num.nil?) || (!num.positive?) || (!num.is_a? Numeric)
    true
  end


end
