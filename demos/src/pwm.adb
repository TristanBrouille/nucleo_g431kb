with Interfaces.STM32.RCC;  use Interfaces.STM32.RCC;
with Interfaces.STM32.GPIO; use Interfaces.STM32.GPIO;
with Interfaces.STM32.TIM; use Interfaces.STM32.TIM;

with Board;
pragma Unreferenced (Board);

procedure PWM is
   type Duty_Cycle is range 0 .. 99;
   DC : Duty_Cycle := Duty_Cycle'First;
begin
   RCC_Periph.AHB2ENR.GPIOAEN := 1;             -- Enable GPIOA clock
   RCC_Periph.APB2ENR.TIM1EN  := 1;             -- Enable TIM1 clock
   GPIOA_Periph.MODER.Arr (8) := 2#10#;         -- Alternate Function
   GPIOA_Periph.AFRH.Arr (8)  := 6;             -- AF6 = TIM1_CH1
   GPIOA_Periph.OSPEEDR.Arr (8) := 2#11#;       -- High speed
   GPIOA_Periph.OTYPER.OT.Arr (8) := 0;         -- Push-pull
   GPIOA_Periph.PUPDR.Arr (8) := 2#00#;         -- No pull
   TIM1_Periph.PSC.PSC := PSC_PSC_Field (1699); -- Prescaler for 10 kHz timer clock
   TIM1_Periph.ARR.ARR := ARR_ARR_Field (99);   -- Auto-reload value for 100 Hz PWM
   TIM1_Periph.CCMR1_Output.CC1S := 0;          -- CC1 channel is output
   TIM1_Periph.CCMR1_Output.OC1M := 2#110#;     -- PWM Mode 1
   TIM1_Periph.CCMR1_Output.OC1PE := 1;         -- Preload enable
   TIM1_Periph.CCER.CC1E := 1;                  -- Enable CH1 output
   TIM1_Periph.CR1.ARPE := 1;                   -- Auto-reload preload enable
   TIM1_Periph.EGR.UG := 1;                     -- Update generation to apply settings
   TIM1_Periph.CR1.CEN := 1;                    -- Enable TIM1 counter
   TIM1_Periph.BDTR.MOE := 1;                   -- Main output enable
   loop
      TIM1_Periph.CCR1.CCR1 := CCR1_CCR1_Field (DC);  -- Set duty cycle
      delay 0.01;
      DC := DC + 1;
      if DC = Duty_Cycle'Last then
         DC := Duty_Cycle'First;                      -- Reset to 0% duty cycle
      end if;
   end loop;
end PWM;
