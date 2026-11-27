set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR avr)

find_program(AVR_GCC        "${CMAKE_SOURCE_DIR}/vendor/avr-win32-toolchain/bin/avr-gcc.exe")
find_program(AVR_OBJCOPY    "${CMAKE_SOURCE_DIR}/vendor/avr-win32-toolchain/bin/avr-objcopy.exe")
find_program(AVR_SIZE       "${CMAKE_SOURCE_DIR}/vendor/avr-win32-toolchain/bin/avr-size.exe")
find_program(AVRDUDE        "${CMAKE_SOURCE_DIR}/vendor/avrdude-win32/avrdude.exe")

set(CMAKE_C_COMPILER ${AVR_GCC})
