# This is an INTERFACE target for Clang, usage:
#   target_link_libraries(${PROJECT_NAME} <PRIVATE|PUBLIC|INTERFACE> Clang-Wrapper)
# The include directories and compile definitions will be properly handled.
include_guard()

set(CMAKE_FOLDER_LLVM "${CMAKE_FOLDER}")

if(CMAKE_FOLDER)
  set(CMAKE_FOLDER "${CMAKE_FOLDER}/LLVM")
else()
  set(CMAKE_FOLDER "LLVM")
endif()

# Find Clang
find_package(Clang REQUIRED CONFIG)

set(CLANG_LIBRARIES "")

foreach(target IN LISTS CLANG_EXPORTED_TARGETS)
  get_target_property(target_type ${target} TYPE)

  # Executables and clangAnalysis* are not included
  if(NOT(target_type STREQUAL "EXECUTABLE") AND NOT(target MATCHES ".*clangAnalysis.*"))
    list(APPEND CLANG_LIBRARIES ${target})
  endif()
endforeach()

message(STATUS "Using ClangConfig.cmake in: ${CLANG_CMAKE_DIR}")
message(STATUS "Clang libraries: ${CLANG_LIBRARIES}")
message(STATUS "Clang includes: ${CLANG_INCLUDE_DIRS}")

add_library(Clang-Wrapper INTERFACE)
target_include_directories(Clang-Wrapper SYSTEM INTERFACE ${CLANG_INCLUDE_DIRS})

if(CLANG_LINK_CLANG_DYLIB)
  # target_link_libraries(Clang-Wrapper INTERFACE clang-cpp)  # Official way?
  target_link_libraries(Clang-Wrapper INTERFACE ${CLANG_LIBRARIES})
else()
  target_link_libraries(Clang-Wrapper INTERFACE ${CLANG_LIBRARIES})
endif()

set(CMAKE_FOLDER "${CMAKE_FOLDER_LLVM}")
unset(CMAKE_FOLDER_LLVM)
