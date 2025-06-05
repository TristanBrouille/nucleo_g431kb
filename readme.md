# nucleo_g431kb
The NUCLEO-G431KB is a 30-pin STM32G4 dev board with the STM32G431KBU6 MCU (Cortex-M4 @ 170 MHz) with FPU and DSP extensions.

## Prerequisites
- The Ada package manager [alire](https://alire.ada.dev/).
- **Important**: Install the GAP alire index to access the package dependencies for this project

```
alr index --add git+https://github.com/GNAT-Academic-Program/gap-alire-index --name gap
```

## Building

The following runtimes are supported and can be swapped in by editing the `alire.toml` manifest:

- `light_stm32g431 = "*"`
- `light_tasking_stm32g431 = "*"`
- `embedded_stm32g431 = "*"`


## Demos

To build the demos firmware:
```
cd demos  
alr build
```

These are:
- blinky (board user led flashes at 1 Hz)
- pwm (a variable pwm is emitted on PA8)
- sysclk (the 170 Mhz system clock is outputted on PA8)

## Flashing
Using [openocd](https://github.com/openocd-org/openocd)
```
openocd -f interface/stlink.cfg -f target/stm32g4x.cfg -c "program bin/blinky verify reset exit"
```

## MCU

- MCU: STM32G431KBU6 (STM32G4 series)
- Package: UFQFPN32 (5×5 mm)
- Core: ARM Cortex-M4 @ 170 MHz  
  - Single-precision FPU  
  - DSP instructions  
  - CORDIC and FMAC hardware math accelerators
- Flash: 128 KB with ECC, PCROP, securable regions
- RAM: 32 KB total  
  - 22 KB main SRAM  
  - 10 KB CCM (tightly coupled memory)


## Peripherals

- **ADC**: 2x ADCs (up to 23 channels, 16-bit with oversampling)
- **DAC**: 2x 12-bit DAC channels (buffered and unbuffered)
- **Timers**:
  - 1x 32-bit general-purpose
  - 5x 16-bit advanced/generic timers (PWM, IC/OC, encoder)
  - 2x watchdog timers
  - 1x SysTick (24-bit)
  - 1x low-power timer
- **Analog**:
  - 4x comparators
  - 3x op-amps (PGA mode capable)
  - Internal VREF buffer (2.048 V, 2.5 V, 2.9 V)
- **Communication**:
  - 3x I2C (Fast Mode+)
  - 4x USART/UART + 1x LPUART
  - 3x SPI (2 with I2S support)
  - 1x SAI (serial audio)
  - 1x USB 2.0 Full Speed (device only, via ST-LINK USB)
  - 1x FDCAN
- **Other**:
  - True random number generator (TRNG)
  - CRC unit
  - 96-bit unique ID
  - 12-channel DMA
  - Calendar RTC + backup registers
  - Full interrupt support on all GPIOs
- **Debug**: SWD, onboard ST-LINK/V2-1 (CMSIS-DAP and VCP)

Note: Some peripherals may not be broken out on the 30-pin Nucleo-32 header. Refer to the ST schematic for pin availability.


## Pin Map

```
                 ______
         _______|      |______
        |       |______|      |
        |                     |
        |    nucleo_g431kb    |    
        |                     |
PA9  -> | 1                 1 | <- D3v3
PA10 -> | 2                 2 | <- 0V
nRST -> | 3                 3 | <- nRST
0V   -> | 4                 4 | <- +5v0
PA12 -> | 5                 5 | <- PA2
PB0  -> | 6                 6 | <- PA7
PB7  -> | 7                 7 | <- PA6/PA15
PA15 -> | 8                 8 | <- PA5/PB7
PB6  -> | 9                 9 | <- PA4
PF0  -> |10                 10| <- PA3
PF1  -> |11                 11| <- PA1
PA8  -> |12                 12| <- PA0
PA11 -> |13                 13| <- A3v3
PB5  -> |14                 14| <- +3v3
PB4  -> |15                 15| <- PB3/PB8
        |_____________________|
```

## Hardwired

```
┌──────┬─────────────────────────┬─────────┬─────────────────────────────────────────┐
│ Pin  │ Type                    │ Label   │ Description                             │
├──────┼─────────────────────────┼─────────┼─────────────────────────────────────────┤
│ PB8  │ User LED                │ LD2     │ On board green LED.                     │
│ NRST │ Reset Button            │ B1      │ Active-low reset input, triggers MCU    │
│      │                         │         │ reset.                                  │
│ PA2  │ ST-LINK Virtual COM     │ TX      │ Transmit line for virtual COM port.     │
│ PA15 │ ST-LINK Virtual COM     │ RX      │ Receive line for virtual COM port.      │
│ PF0  │ HSE Oscillator Input    │ OSC_IN  │ High-speed external clock input.        │
│ PF1  │ HSE Oscillator Output   │ OSC_OUT │ High-speed external clock output.       │
└──────┴─────────────────────────┴─────────┴─────────────────────────────────────────┘
```
