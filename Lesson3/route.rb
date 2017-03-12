# - Имеет начальную и конечную станцию, а также список промежуточных станций.
# Начальная и конечная станции указываютсся при создании маршрута,
# а промежуточные могут добавляться между ними.
# - Может добавлять промежуточную станцию в список
# - Может удалять промежуточную станцию из списка
# - Может выводить список всех станций по-порядку от начальной до конечной

class Route
  attr_reader :list

  def initialize(start_name, end_name)
    @list = [start_name,end_name]
  end

  def add_station(name,number)
    if number == 0 || number > @list.size - 1
      raise ArgumentError, "Номер добавляемой станции должен быть между первой (1) и последней (#{@list.size})"
    else
      @list.insert(number, name)
    end
  end

  def del_station_by_name(st_name)
    id_st_to_del = @list.find_index { |st| st.name == st_name}
    if id_st_to_del == 0 || id_st_to_del == @list.size - 1
      raise ArgumentError, "Нельзя удалять первую и последнюю станции."
    elsif id_st_to_del.nil?
      raise ArgumentError, "Станции \"#{st_name}\" нет в маршруте."
    else
      @list.delete_at(id_st_to_del)
    end
  end

  def del_station_by_number(number)
    if number == 0 || number >= @list.size - 1
      raise ArgumentError, "Номер удаляемой станции должен быть между первой (1) и последней (#{@list.size})"
    else
      @list.delete_at(number)
    end
  end

  def show_list
    @list.each_with_index { |item,index| puts "#{index}:\t#{item.name}" }
  end
end