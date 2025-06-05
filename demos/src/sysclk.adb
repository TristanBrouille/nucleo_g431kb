with Interfaces.STM32.RCC;  use Interfaces.STM32.RCC;
with Interfaces.STM32.GPIO; use Interfaces.STM32.GPIO;

with Board;
pragma Unreferenced (Board);

procedure Sysclk is
begin
   RCC_Periph.CFGR.MCOSEL := 5;           -- 5 = SYSCLK
   RCC_Periph.CFGR.MCOPRE := 0;           -- No division
   RCC_Periph.AHB2ENR.GPIOAEN := 1;       -- Enable GPIOA clock
   GPIOA_Periph.MODER.Arr (8) := 2#10#;   -- Alternate Function mode
   GPIOA_Periph.OTYPER.OT.Arr (8) := 0;   -- Push-pull
   GPIOA_Periph.PUPDR.Arr (8) := 2#00#;   -- No pull
   GPIOA_Periph.OSPEEDR.Arr (8) := 2#11#; -- Very high speed
   GPIOA_Periph.AFRH.Arr (8) := 0;        -- AF0 = MCO on PA8
   loop
      delay 1.0;
   end loop;
end Sysclk;
