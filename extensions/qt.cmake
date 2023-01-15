# Provides a very basic easy and basic way to integrate
# a Qt app and lib.
#
# Simply use this order of calls:
# - cppstruct_qt()
# - cppstruct_qt_packages(Core Gui Widgets ...)
# - cppstruct_app/lib(...)
# - ... more custom commands ...
# - cppstruct_qt_link
#
# Thats it!

# Macro to initialize a basic Qt project.
# Sets required variables.
macro(cppstruct_qt)
	set(CMAKE_INCLUDE_CURRENT_DIR ON)
	set(CMAKE_AUTOMOC ON)
	set(CMAKE_AUTOUIC ON)
	set(CMAKE_AUTORCC ON)
	find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core)
endmacro()

# Finds Qt libraries with `find_package()`.
# ARG parameters are the required Qt libraries, e.g. "Core Gui Widgets"
function(cppstruct_qt_packages)
	foreach(arg IN LISTS ARGN)
		find_package(Qt${QT_VERSION_MAJOR}${arg} REQUIRED)
	endforeach()
endfunction()

# Adds source files categorized as QML.
# Optional
# function(cppstruct_qt_qml)
# 	set(sources_dir ${CMAKE_CURRENT_SOURCE_DIR}/src)
# 	foreach(arg IN LISTS ARGN)
# 		target_sources(${app_name} PRIVATE ${sources_dir}/${arg})
# 		source_group(QtQml ${CMAKE_CURRENT_SOURCE_DIR} FILES ${sources_dir}/${arg})
# 	endforeach()
# endfunction()

# function(cppstruct_qt_forms)
# 	set(sources_dir ${CMAKE_CURRENT_SOURCE_DIR}/src)
# 	foreach(arg IN LISTS ARGN)
# 		target_sources(${app_name} PRIVATE ${sources_dir}/${arg})
# 		source_group(QtForms ${CMAKE_CURRENT_SOURCE_DIR} FILES ${sources_dir}/${arg})
# 	endforeach()
# endfunction()

# function(cppstruct_qt_res)
# 	set(sources_dir ${CMAKE_CURRENT_SOURCE_DIR}/src)
# 	foreach(arg IN LISTS ARGN)
# 		target_sources(${app_name} PRIVATE ${sources_dir}/${arg})
# 		source_group(QtRes ${CMAKE_CURRENT_SOURCE_DIR} FILES ${sources_dir}/${arg})
# 	endforeach()
# endfunction()

# Links against Qt libraries.
# In addition we link against OpenGL, which is required by Qt.
# ARG parameters are the required Qt libraries, e.g. "Core Gui Widgets"
function(cppstruct_qt_link app_name)
	foreach(arg IN LISTS ARGN)
		target_link_libraries(${app_name} PRIVATE Qt${QT_VERSION_MAJOR}::${arg})
	endforeach()

	# WARNING!
	# We always link a few libs for convinience.
	# TODO: Only do this, if required by libs.
	# if(TRUE)
	# 	if(WIN32)
	# 		target_link_libraries(
	# 			${app_name}
	# 			PRIVATE OpenGL32.lib
	# 		)
	# 	endif(WIN32)
	# 	if(UNIX)
	# 		target_link_libraries(
	# 			${app_name}
	# 			PRIVATE GL
	# 		)
	# 	endif(UNIX)
	# endif(TRUE)
endfunction()