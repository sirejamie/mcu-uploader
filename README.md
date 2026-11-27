# MCU Uploader

A small uploader for AVR based microcontrollers.

## Supported Platforms

* Windows

## Dependencies

* [AVR toolchain](https://www.microchip.com/en-us/tools-resources/develop/microchip-studio/gcc-compilers)
* [avrdude](https://github.com/avrdudes/avrdude)

## Commands

Configure & Generate

> This configuration is an example for the ATmega328p. The command was ran in Windows PowerShell; note the backticks for multi-line commands.

```sh
cmake -G "Ninja" -B build -S . `
    -DUPLOADER_MCU="atmega328p" `
    -DUPLOADER_CPU_FREQ="16000000" `
    -DUPLOADER_AVRDUDE_PARTNO="m328p" `
    -DUPLOADER_AVRDUDE_PROGRAMMER="stk500v2" `
    -DUPLOADER_AVRDUDE_PORT="COM8"
```

Build & Upload

> The build gets converted to an Intel hex file and is uploaded to the microcontroller using avrdude. These can be changed in the [CMakeLists.txt](./CMakeLists.txt).

```sh
cmake --build build
```

## References

* [AVR Lib-C Documentation](https://avrdudes.github.io/avr-libc/avr-libc-user-manual/)

## License

[MIT](./LICENSE)
