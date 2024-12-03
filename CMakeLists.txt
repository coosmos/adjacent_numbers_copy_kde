cmake_minimum_required(VERSION 3.16)

project(playground3 VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appplayground3
    main.cpp
)

qt_add_qml_module(appplayground3
    URI playground3
    VERSION 1.0
    QML_FILES
        Main.qml
        QML_FILES DraggableTile.qml
        SOURCES
        QML_FILES nav_keyboard.qml
        QML_FILES nav_keyB_dragM.qml
        QML_FILES row_nav_child_navkeyB.qml
        QML_FILES adjacent_no_copy.qml
        QML_FILES logic.js
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appplayground3 PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appplayground3
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appplayground3
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appplayground3
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
