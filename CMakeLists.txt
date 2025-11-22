cmake_minimum_required(VERSION 3.16)

project(aimo_projekt VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS Core)
find_package(Qt6 REQUIRED COMPONENTS Core)
find_package(Qt6 REQUIRED COMPONENTS Core)
find_package(Qt6 REQUIRED COMPONENTS Core)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appaimo_projekt
    main.cpp
)

qt_add_qml_module(appaimo_projekt
    URI aimo_projekt
    QML_FILES
        Main.qml
        SOURCES greywolfoptimizer.h greywolfoptimizer.cpp
        SOURCES
        SOURCES
        SOURCES opt_params.h
        SOURCES analysis_params.h
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appaimo_projekt PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appaimo_projekt
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appaimo_projekt
    PRIVATE Qt6::Quick
)
target_link_libraries(appaimo_projekt PRIVATE Qt6::Core)
target_link_libraries(appaimo_projekt PRIVATE Qt6::Core)
target_link_libraries(appaimo_projekt PRIVATE Qt6::Core)
target_link_libraries(appaimo_projekt PRIVATE Qt6::Core)

include(GNUInstallDirs)
install(TARGETS appaimo_projekt
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
