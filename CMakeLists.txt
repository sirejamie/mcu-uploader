cmake_minimum_required(VERSION 3.20..3.41)

set(CMAKE_TOOLCHAIN_FILE "${CMAKE_SOURCE_DIR}/cmake/avr-win32-toolchain.cmake")

project(mcu-uploader
    DESCRIPTION "A small uploader for AVR based microcontrollers."
    VERSION 1.0.0
    LANGUAGES C
)

set(UPLOADER_MCU "atmega328p" CACHE STRING "[mcu-uploader] microcontroller unit")
set(UPLOADER_CPU_FREQ "16000000" CACHE STRING "[mcu-uploader] CPU clock frequency")

set(UPLOADER_AVRDUDE_PARTNO "m328p" CACHE STRING "[avrdude] part number")
set(UPLOADER_AVRDUDE_PROGRAMMER "stk500v2" CACHE STRING "[avrdude] programmer type")
set(UPLOADER_AVRDUDE_PORT "COM8" CACHE STRING "[avrdude] programming port")

set(mcu-uploader.definitions F_CPU=${UPLOADER_CPU_FREQ})
set(mcu-uploader.compiler-options -Wall -Werror -Wpedantic -Os -mmcu=${UPLOADER_MCU})
set(mcu-uploader.linker-options -Wl,--gc-sections -mmcu=${UPLOADER_MCU})

add_executable(mcu-uploader src/main.c)
target_compile_definitions(mcu-uploader PUBLIC ${mcu-uploader.definitions})
target_compile_options(mcu-uploader PUBLIC ${mcu-uploader.compiler-options})
target_link_options(mcu-uploader PUBLIC ${mcu-uploader.linker-options})
target_compile_features(mcu-uploader PUBLIC c_std_11)
target_include_directories(mcu-uploader PUBLIC vendor/avr-win32-toolchain/avr/include)
set_target_properties(mcu-uploader PROPERTIES SUFFIX ".elf")

add_custom_command(
    TARGET mcu-uploader
    POST_BUILD
    COMMAND ${AVR_SIZE} $<TARGET_FILE:mcu-uploader>
    COMMAND ${AVR_OBJCOPY} -O ihex $<TARGET_FILE:mcu-uploader> $<TARGET_FILE_BASE_NAME:mcu-uploader>.hex
    COMMAND ${AVRDUDE} -c ${UPLOADER_AVRDUDE_PROGRAMMER} -p ${UPLOADER_AVRDUDE_PARTNO} -P ${UPLOADER_AVRDUDE_PORT} -U flash:w:$<TARGET_FILE_BASE_NAME:mcu-uploader>.hex:i -v
)