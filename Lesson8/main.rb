require_relative 'interface'

options = {
  quit: 'Выход',
  add_station: 'Создать станцию',
  add_train: 'Создать поезд',
  add_route: 'Создать маршрут',
  insert_station: 'Добавить станцию в маршрут',
  remove_station: 'Удалить станцию из маршрута',
  assign_route: 'Назначать маршрут поезду',
  add_carriage: 'Добавить вагон к поезду',
  reserve: 'Занять место в вагоне',
  rem_carriage: 'Отцепить вагон от поезда',
  train_forward: 'Переместить поезд вперед по маршруту',
  train_back: 'Переместить поезд назад по маршруту',
  all_stations: 'Посмотреть список станций',
  all_routes: 'Посмотреть список маршрутов',
  all_trains: 'Посмотреть список поездов',
  autogen: 'Автоматическая генерация тестовых объектов',
  station_info: 'Посмотреть список поездов на станции',
  train_info: 'Информация по определенному поезду'
}

main_menu = Interface.new

main_menu.menu(options)
