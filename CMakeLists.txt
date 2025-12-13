cmake_minimum_required(VERSION 3.19)

project(aimo_projekt VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS
    Quick
    Core
)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appaimo_projekt
    main.cpp
)

qt_add_qml_module(appaimo_projekt
    URI aimo_projekt
    QML_FILES
        Main.qml
        Analysis.qml
        Optimization.qml
    SOURCES
        greywolfoptimizer.cpp greywolfoptimizer.h
        opt_params.h
        analysis_params.h
)

set_target_properties(appaimo_projekt PROPERTIES
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appaimo_projekt
    PRIVATE
        Qt6::Quick
        Qt6::Core
)

include(InstallRequiredSystemLibraries)
install(TARGETS appaimo_projekt)
qt_generate_deploy_qml_app_script(
    TARGET appaimo_projekt
    OUTPUT_SCRIPT DEPLOY_SCRIPT
    NO_TRANSLATIONS
)
install(SCRIPT ${DEPLOY_SCRIPT})
