# - Имеет начальную и конечную станцию, а также список промежуточных станций.
# Начальная и конечная станции указываютсся при создании маршрута,
# а промежуточные могут добавляться между ними.
# - Может добавлять промежуточную станцию в список
# - Может удалять промежуточную станцию из списка
# - Может выводить список всех станций по-порядку от начальной до конечной

class Route
  attr_reader :stations, :name, :all_routes
  @@all_routes = []

  def initialize(name, start_name, end_name)
    @stations = [start_name, end_name]
    @name = name
    @@all_routes << self
  end

  def add_station(name, number)
    if number == 0 || number > @stations.size - 1
      raise ArgumentError, "Номер добавляемой станции должен быть между первой (1) и последней (#{@stations.size})"
    else
      @stations.insert(number, name)
    end
  end

  def del_station_by_name(st_name)
    station_index = @stations.find_index { |st| st.name == st_name }
    if station_index == 0 || station_index == @stations.size - 1
      raise ArgumentError, "Нельзя удалять первую и последнюю станции."
    elsif station_index.nil?
      raise ArgumentError, "Станции \"#{st_name}\" нет в маршруте."
    else
      @stations.delete_at(station_index)
    end
  end

  def del_station_by_number(number)
    if number == 0 || number >= @stations.size - 1
      raise ArgumentError, "Номер удаляемой станции должен быть между первой (1) и последней (#{@stations.size})"
    else
      @stations.delete_at(number)
    end
  end

  def show_list
    @stations.each_with_index { |item, index| puts "#{index}:\t#{item.name}" }
  end

  def self.all_names
    @@all_routes.map { |route| route.name }
  end
end