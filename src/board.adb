pragma Suppress (All_Checks);

with Interfaces.STM32;       use Interfaces.STM32;
with Interfaces.STM32.Flash; use Interfaces.STM32.Flash;
with Interfaces.STM32.RCC;   use Interfaces.STM32.RCC;
with Interfaces.STM32.PWR;   use Interfaces.STM32.PWR;

package body Board is
   procedure Setup_Board is
   begin
      --  Enable PWR
      RCC_Periph.APB1ENR1.PWREN := 1;
      RCC_Periph.APB1RSTR1.PWRRST := 1;
      RCC_Periph.APB1RSTR1.PWRRST := 0;

      --  Voltage scaling
      PWR_Periph.CR1.VOS := 1;
      loop
         exit when PWR_Periph.SR2.VOSF = 0;
      end loop;

      --  Enable HSI
      RCC_Periph.CR.HSION := 1;
      loop
         exit when RCC_Periph.CR.HSIRDY = 1;
      end loop;

      --  Configure PLL
      RCC_Periph.PLLSYSCFGR :=
        (PLLSYSM   => 3,                  --  /4
         PLLSYSN   => 85,                 --  *85
         PLLSYSP   => 0, PLLPEN    => 1,  --  /2
         PLLSYSQ   => 0, PLLSYSQEN => 1,  --  /2
         PLLSYSR   => 0, PLLSYSREN => 1,  --  /2
         PLLSRC    => 2,                  --  HSI16
         others => <>);

      --  Enable PLL
      RCC_Periph.CR.PLLSYSON := 1;
      loop
         exit when RCC_Periph.CR.PLLSYSRDY = 1;
      end loop;

      --  Flash latency must be set before faster clocks
      FLASH_Periph.ACR :=
        (LATENCY => 4,
         ICEN    => 1,
         DCEN    => 1,
         PRFTEN  => 1,
         others  => <>);

      --  Set prescalers
      RCC_Periph.CFGR.HPRE := 0;                             --  /1
      RCC_Periph.CFGR.PPRE := (As_Array => False, Val => 0); --  /1

      --  Select SYSCLK source: PLL
      RCC_Periph.CFGR.SW := 2#11#;

      --  Wait for switch to PLL
      loop
         exit when RCC_Periph.CFGR.SWS = 2#11#;
      end loop;
   end Setup_Board;

end Board;
