require_relative 'station'
require_relative 'route'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_car'
require_relative 'passenger_car'
require_relative 'interface'

options = [
    {quit: 'Выход'},
    {add_station: 'Создать станцию'},
    {add_train: 'Создать поезд'},
    {add_route: 'Создать маршрут'},
    {insert_station: 'Добавить станцию в маршрут'},
    {remove_station: 'Удалить станцию из маршрута'},
    {assign_route: 'Назначать маршрут поезду'},
    {add_carriage: 'Добавить вагон к поезду'},
    {rem_carriage: 'Отцепить вагон от поезда'},
    {train_forward: 'Переместить поезд вперед по маршруту'},
    {train_back: 'Переместить поезд назад по маршруту'},
    {all_stations: 'Посмотреть список станций'},
    {all_routes: 'Посмотреть список маршрутов'},
    {all_trains: 'Посмотреть список поездов'},
    {trains_by_station: 'Посмотреть список поездов на станции'}
]

main_menu = Interface.new

main_menu.menu(options)
