# TODO
# \param library_name
# \param static_or_shared Can be STATIC or SHARED
function(cppstruct_lib library_name static_or_shared)
	add_library(
		${library_name}
		${static_or_shared}
	)
	_cppstruct_lib_all(${library_name})
endfunction()

# Adds private headers to library.
# Location: "src/"
function(cppstruct_lib_headers library_name)
	set(headers_dir ${CMAKE_CURRENT_SOURCE_DIR}/src)

	foreach(arg IN LISTS ARGN)
		target_sources(${library_name} PRIVATE ${headers_dir}/${arg})
	endforeach()
endfunction()

# Adds public headers to library.
# Location: "include/library_name/"
function(cppstruct_lib_headers_public library_name)
	set(headers_dir ${CMAKE_CURRENT_SOURCE_DIR}/include/${library_name})

	foreach(arg IN LISTS ARGN)
		target_sources(${library_name} PRIVATE ${headers_dir}/${arg})
	endforeach()
endfunction()

# Adds implementation files to library.
# Location: "src/"
function(cppstruct_lib_sources library_name)
	set(sources_dir ${CMAKE_CURRENT_SOURCE_DIR}/src)

	foreach(arg IN LISTS ARGN)
		target_sources(${library_name} PRIVATE ${sources_dir}/${arg})
	endforeach()
endfunction()

# Generates a header file, which includes C++ macros for DLL exports.
# e.g. __declspec(...)
function(cppstruct_lib_export_hpp library_name)
	string(TOUPPER ${library_name} library_name_uppercase)
	configure_file(
		"${CMAKE_CURRENT_FUNCTION_LIST_DIR}/libs-export.hpp.in"
		${CMAKE_CURRENT_SOURCE_DIR}/include/${library_name}/export.hpp
	)
endfunction()

#######################################################################
# Private Functions
#######################################################################

function(_cppstruct_lib_all library_name)
	set_target_properties(
		${library_name}
		PROPERTIES
		POSITION_INDEPENDENT_CODE ON
		FOLDER libs
	)
	target_include_directories(
		${library_name}
		PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include
	)

	# Defines a export macro required for DLLs on Windows.
	string(TOUPPER ${library_name} library_name_uppercase)
	target_compile_definitions(
		${library_name}
		PRIVATE ${library_name_uppercase}_EXPORT
	)

	# # WARNING!
	# # We simply always link against the Windows's socket library,
	# # even if we don't use it on that specific library.
	# if(WIN32)
	# 	target_link_libraries(
	# 		${library_name}
	# 		PRIVATE Ws2_32.lib
	# 	)
	# endif(WIN32)
endfunction()