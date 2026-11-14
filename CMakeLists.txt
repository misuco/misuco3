cmake_minimum_required(VERSION 3.16)

project(misuco3 VERSION 0.2 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick Multimedia Network)

qt_standard_project_setup(REQUIRES 6.5)

# FluidSynth is the soundfont engine behind polysoundfont. Only the synth
# core is built, as a static library: no audio or midi drivers and no
# external dependencies, the audio output is done with Qt.
#   git submodule update --init --recursive
function(misuco3_add_fluidsynth)
    if(NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/fluidsynth/gcem/CMakeLists.txt")
        message(FATAL_ERROR "fluidsynth/gcem is missing, run: git submodule update --init --recursive")
    endif()

    set(BUILD_SHARED_LIBS OFF)
    set(osal "cpp11" CACHE STRING "" FORCE)
    # single precision dsp, cheaper on mobile cpus
    set(enable-floats ON CACHE BOOL "" FORCE)
    foreach(feature
            alsa aufile dbus ipv6 jack ladspa libsndfile midishare opensles oboe
            network oss dsound wasapi waveout winmidi sdl3 pulseaudio pipewire
            readline openmp native-dls signalsmith systemd coreaudio coremidi
            framework dart kai portaudio profiling)
        set(enable-${feature} OFF CACHE BOOL "" FORCE)
    endforeach()

    add_subdirectory(fluidsynth EXCLUDE_FROM_ALL)
endfunction()
misuco3_add_fluidsynth()

qt_add_executable(MISUCO3
    main.cpp
)

qt_add_qml_module(MISUCO3
    URI misuco3
    VERSION 1.0
    QML_FILES
        qml/Main.qml
        qml/NetworkMidi.qml
        qml/NetworkMidiForm.ui.qml
        qml/AudioDevice.qml
        qml/AudioDeviceForm.ui.qml
        qml/ColorPalette.js
        qml/ControlArea.qml
        qml/ControlBarRange.qml
        qml/ControlButton.qml
        qml/ControlDial.qml
        qml/ControlEmboss.qml
        qml/ControlLabelTuning.qml
        qml/ControlSlider.qml
        qml/ControlSliderRange.qml
        qml/ControlSliderTuning.qml
        qml/ControlTuning.qml
        qml/PlayArea.qml
        qml/Parameters_Arp.qml
        qml/Parameters_ArpForm.ui.qml
        qml/Parameters_Filter.qml
        qml/Parameters_FilterForm.ui.qml
        qml/Parameters_FilterEnvelopeForm.ui.qml
        qml/Parameters_Mod.qml
        qml/Parameters_ModForm.ui.qml
        qml/Parameters_Osc_1.qml
        qml/Parameters_Osc_1Form.ui.qml
        qml/Parameters_Osc_2.qml
        qml/Parameters_Osc_2Form.ui.qml
        qml/Parameters_Osc_WaveOctaveGrid.ui.qml
        qml/Parameters_VolumeEnvelopeForm.ui.qml
        qml/Parameters_FilterEnvelopeForm.ui.qml
        qml/Parameters_VolumeEnvelope.qml
        qml/Parameters_FilterEnvelope.qml
        qml/PresetManager.qml
        qml/PresetSaveDialog.qml
        qml/RangeConfig.qml
        qml/RangeConfigForm.ui.qml
        qml/ScaleConfig.qml
        qml/ScaleConfigForm.ui.qml
        qml/SoundFont.qml
        qml/SoundFontForm.ui.qml
        qml/Tuning.qml
        qml/TuningForm.ui.qml
        qml/XYAssignableParameter.qml
        qml/XYModAssign.qml
        qml/XYModAssignForm.ui.qml
    RESOURCES
        qml/icons/wave-sine.svg
        qml/icons/wave-square.svg
        qml/icons/wave-tri.svg
        qml/icons/wave-saw.svg
        qml/icons/wave-saw-rev.svg
        qml/fonts/alpha-prota/AlphaProta.otf
        qml/factory_presets.json
        fluidsynth/sf2/VintageDreamsWaves-v2.sf2
        fluidsynth/sf2/COPYRIGHT.txt

    SOURCES
        src/presetstore.cpp
        src/presetstore.h

        misulib/comm/heartbeat.cpp
        misulib/comm/heartbeat.h
        misulib/comm/bonjourannouncer.cpp
        misulib/comm/bonjourannouncer.h
        misulib/comm/mastersender.cpp
        misulib/comm/mastersender.h
        misulib/comm/mdnsbrowser.cpp
        misulib/comm/mdnsbrowser.h
        misulib/comm/rtpmidicontrol.cpp
        misulib/comm/rtpmidicontrol.h
        misulib/comm/sendermobilesynth.cpp
        misulib/comm/sendermobilesynth.h
        misulib/comm/senderoscmidigeneric.cpp
        misulib/comm/senderoscmidigeneric.h
        misulib/comm/sendersoundfont.cpp
        misulib/comm/sendersoundfont.h
        misulib/comm/senderreaktor.cpp
        misulib/comm/senderreaktor.h
        misulib/comm/senderrtpmidi.cpp
        misulib/comm/senderrtpmidi.h
        misulib/comm/sendersupercollider.cpp
        misulib/comm/sendersupercollider.h
        misulib/comm/senderthread.cpp
        misulib/comm/senderthread.h

        misulib/comm/libofqf/qoscclient.cpp
        misulib/comm/libofqf/qoscclient.h
        misulib/comm/libofqf/qoscmsgparser.cpp
        misulib/comm/libofqf/qoscmsgparser.h
        misulib/comm/libofqf/qoscserver.cpp
        misulib/comm/libofqf/qoscserver.h
        misulib/comm/libofqf/qoscserverinterface.h
        misulib/comm/libofqf/qosctcpclient.cpp
        misulib/comm/libofqf/qosctcpclient.h
        misulib/comm/libofqf/qosctypes.cpp
        misulib/comm/libofqf/qosctypes.h

        polysoundfont/qt6/soundfontsynth.cpp
        polysoundfont/qt6/soundfontsynth.h

        polymobilesynth/qt6/audiosource.h
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

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(MISUCO3 PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
    QT_ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android"
    QT_ANDROID_PACKAGE_NAME "org.misuco.misuco3"
    QT_ANDROID_APP_NAME "MISUCO3"
    QT_ANDROID_TARGET_SDK_VERSION 36
    QT_ANDROID_MIN_SDK_VERSION 28
    QT_ANDROID_VERSION_NAME "1.0-RC1-20260927"
    QT_ANDROID_VERSION_CODE 11
)

target_include_directories(MISUCO3 PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/src
    polymobilesynth/mobilesynth/Classes
    polymobilesynth/qt6
    polysoundfont/qt6
    misulib/comm
)

target_link_libraries(MISUCO3
    PRIVATE Qt6::Quick
    PRIVATE Qt6::Multimedia
    PRIVATE Qt6::Network
    PRIVATE libfluidsynth
)

# the Bonjour announcement of the network midi session (DnsServiceRegister)
if(WIN32)
    target_link_libraries(MISUCO3 PRIVATE dnsapi)
endif()

include(GNUInstallDirs)

install(TARGETS MISUCO3
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_LIBDIR}
)
