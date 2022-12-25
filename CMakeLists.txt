cmake_minimum_required(VERSION 3.5)

project(TinyDevBrowser
	LANGUAGES CXX
	VERSION 0.1
)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(PROJECT_SOURCES_QML
	main.qml
	AddressBar.qml
	ControlButton.qml
	Controls.qml
)

set(PROJECT_SOURCES
	main.cpp
	filechangemonitor.cpp filechangemonitor.h
)

find_package(Qt6 COMPONENTS
	Core
	Quick
)

add_executable(TinyDevBrowser ${PROJECT_SOURCES})

qt_add_qml_module(TinyDevBrowser
	QML_FILES ${PROJECT_SOURCES_QML}
	URI tinyDevBrowser
	VERSION 1.0
)

qt_add_resources(TinyDevBrowser controlIcons
	PREFIX icons
	FILES refresh.svg onTop.svg)

target_link_libraries(TinyDevBrowser PRIVATE
	Qt::Core
	Qt::Quick
)

