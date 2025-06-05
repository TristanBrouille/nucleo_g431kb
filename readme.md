# nucleo_g431kb

## Prerequisites (IMPORTANT)
You will need to install the GAP alire index to access the package dependencies for this project

```
alr index --add git+https://github.com/GNAT-Academic-Program/gap-alire-index --name gap
```

## Demos

To build the demos firmware:
```
cd demos  
alr build
```

These demos are 
- blinky (board user led flashes at 1 Hz)
- pwm (a variable pwm is emitted on PA8 Board Pin)
- sysclk (the 170 Mhz system clock is outputted on PA8 Board Pin)

## MCU
- MCU : stm32g431
- Package : UFQFPN32

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
