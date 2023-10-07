include_guard()

include(${CMAKE_CURRENT_LIST_DIR}/LLVM.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/Clang.cmake)

if(NOT TARGET llvm::llvm)
  add_library(llvm::llvm INTERFACE IMPORTED)
endif()

set_property(TARGET llvm::llvm PROPERTY INTERFACE_LINK_LIBRARIES LLVM-Wrapper APPEND)
set_property(TARGET llvm::llvm PROPERTY INTERFACE_LINK_LIBRARIES Clang-Wrapper APPEND)