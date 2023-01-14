# The `apps.cmake` script defines function to create executable projects.
# Structure for apps:
#	`$PROJECT_SOURCE_DIR/`
#		`apps/`
#			`<myproject>/`
#				`src/`
#				`CMakeLists.txt`
#				`README`

# Defines a console application.
function(cppstruct_app_console app_name)
	add_executable(${app_name})
	_cppstruct_app_all(${app_name})
endfunction()

# Defines a non-console/window application.
function(cppstruct_app app_name)
	set(GUI_TYPE "")
	if (WIN32)
		set(GUI_TYPE WIN32)
	endif()
	add_executable(${app_name} ${GUI_TYPE})
	_cppstruct_app_all(${app_name})
endfunction()

# Adds *.h/*.hpp files from `src/` directory.
function(cppstruct_app_headers app_name)
	set(sources_dir ${CMAKE_CURRENT_SOURCE_DIR}/src)
	foreach(arg IN LISTS ARGN)
		target_sources(${app_name} PRIVATE ${sources_dir}/${arg})
	endforeach()
endfunction()

# Adds *.c/*.cpp files from `src/` directory.
function(cppstruct_app_sources app_name)
	set(sources_dir ${CMAKE_CURRENT_SOURCE_DIR}/src)
	foreach(arg IN LISTS ARGN)
		target_sources(${app_name} PRIVATE ${sources_dir}/${arg})
	endforeach()
endfunction()

#######################################################################
# PRIVATE
#######################################################################

function(_cppstruct_app_all app_name)
	set_target_properties(
		${app_name}
		PROPERTIES
		FOLDER apps
	)
	# WARNING!
	# We always link a few libs for convinience.
#	if(TRUE)
#		if(WIN32)
#			target_link_libraries(
#				${app_name}
#				PRIVATE Ws2_32.lib
#			)
#			target_compile_definitions(
#				${app_name}
#				PRIVATE SDL_MAIN_HANDLED
#			)
#		endif(WIN32)
#		if(UNIX)
#			target_link_libraries(
#				${app_name}
#				PRIVATE pthread
#			)
#		endif(UNIX)
#	endif(TRUE)
endfunction()