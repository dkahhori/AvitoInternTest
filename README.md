# Техническое задание для прохождения стажировки для разработчиков Авито.

Приложение отображает Mock-данные сотрудников Авито в UITableView. Их имена, номера телефонов и способности (skills). 
Имена отсортированы в алфавитном порядке. UI написан кодом без использования SwiftUI. 

## Два состояния экрана:
* Случай с данными - стейт экрана, где успешно показываются запрошенные данные. Запросы построены на основе AvitoAPI - локальный Network Manager.
* Cлучай отсутствия сети - стейт экрана, где показывается errorView с заголовком, подзаголовком и кнопкой. При нажатии на кнопку отправляется повторный запрос для фетчинга. 

