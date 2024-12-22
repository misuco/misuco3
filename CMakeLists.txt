cmake_minimum_required(VERSION 3.16)

project(misuco3 VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick Multimedia)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appmisuco3
    main.cpp
    polymobilesynth/qt6/mobilesynth.h
    polymobilesynth/qt6/mobilesynth.cpp
    polymobilesynth/qt6/qt68wraper.h
    polymobilesynth/qt6/qt68wraper.cpp
    polymobilesynth/mobilesynth/Classes/synth/arpeggio.h
    polymobilesynth/mobilesynth/Classes/synth/arpeggio.cpp
    polymobilesynth/mobilesynth/Classes/synth/controller.h
    polymobilesynth/mobilesynth/Classes/synth/controller.cpp
    polymobilesynth/mobilesynth/Classes/synth/envelope.h
    polymobilesynth/mobilesynth/Classes/synth/envelope.cpp
    polymobilesynth/mobilesynth/Classes/synth/filter.h
    polymobilesynth/mobilesynth/Classes/synth/filter.cpp
    polymobilesynth/mobilesynth/Classes/synth/key_stack.h
    polymobilesynth/mobilesynth/Classes/synth/key_stack.cpp
    polymobilesynth/mobilesynth/Classes/synth/lag_processor.h
    polymobilesynth/mobilesynth/Classes/synth/lag_processor.cpp
    polymobilesynth/mobilesynth/Classes/synth/modulation.h
    polymobilesynth/mobilesynth/Classes/synth/modulation.cpp
    polymobilesynth/mobilesynth/Classes/synth/oscillator.h
    polymobilesynth/mobilesynth/Classes/synth/oscillator.cpp
    polymobilesynth/mobilesynth/Classes/synth/parameter.h
    polymobilesynth/mobilesynth/Classes/synth/parameter.cpp
)

qt_add_qml_module(appmisuco3
    URI misuco3
    VERSION 1.0
    QML_FILES
        Main.qml
        Emboss.qml
        ControlArea.qml
        ControlButton.qml
        ControlDial.qml
        ControlSlider.qml
        TouchButton.qml
        Parameters.ui.qml
        Parameters_Mod.ui.qml
        Parameters_Osc.ui.qml
        Parameters_Osc_2.ui.qml
)


# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appmisuco3 PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appmisuco3
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_include_directories(appmisuco3 PUBLIC
    polymobilesynth/mobilesynth/Classes
)

target_link_libraries(appmisuco3
    PRIVATE Qt6::Quick
    PRIVATE Qt6::Multimedia
)

include(GNUInstallDirs)

install(TARGETS appmisuco3
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
