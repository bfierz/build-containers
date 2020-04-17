cmake_minimum_required(VERSION 3.5.0)
project(enum_adapters)
add_executable(enum_adapters main.cpp)
target_link_libraries(enum_adapters d3d12.lib dxgi.lib dxguid.lib)
