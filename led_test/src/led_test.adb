with Interfaces.STM32.RCC;  use Interfaces.STM32.RCC;
with Interfaces.STM32.GPIO; use Interfaces.STM32.GPIO;

with Board;
pragma Unreferenced (Board);

procedure led_test is
begin
   RCC_Periph.AHB2ENR.GPIOBEN := 1;       -- Enable GPIOB clock
   GPIOB_Periph.MODER.Arr (4) := 2#01#;   -- OUTPUT mode
   GPIOB_Periph.OTYPER.OT.Arr (4) := 0;   -- Push-pull
   GPIOB_Periph.PUPDR.Arr (4) := 2#00#;   -- No pull
   GPIOB_Periph.OSPEEDR.Arr (4) := 2#01#; -- Low speed
   GPIOB_Periph.BSRR.BR.Arr (4) := 1;     -- Ensure LED is OFF initially
   
   for I in 1 .. 40 loop
      GPIOB_Periph.BSRR.BS.Arr (4) := 1;  -- LED ON
      delay 0.05;
      GPIOB_Periph.BSRR.BR.Arr (4) := 1;  -- LED OFF
      delay 0.05;
   end loop;
   for I in 1 .. 4 loop
      GPIOB_Periph.BSRR.BS.Arr (4) := 1;  -- LED ON
      delay 0.5;
      GPIOB_Periph.BSRR.BR.Arr (4) := 1;  -- LED OFF
      delay 0.5;
   end loop;
end led_test;
