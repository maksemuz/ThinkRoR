require_relative 'car'
class CargoCarriage < Carriage

  def initialize(space = 1000)
    @space = space
    @free_space = space
    validate!(@space)
  end

  def reserve(vol)
    validate!(vol)
    if @free_space - vol < 0
      raise ArgumentError, 'В вагоне нет свободного места, бронирование не удалось'
    end
    @free_space -= vol
  end

  def free
    @free_space
  end

  def busy
    @space - @free_space
  end

  private

  def validate!(num)
    if (!num.is_a? Numeric) || (!num.positive?)
      raise ArgumentError, "Объем #{num} должен быть положительным числом"
    end
    true
  end
  
end
