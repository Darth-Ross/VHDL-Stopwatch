----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 03.12.2018 17:50:16
-- Design Name:
-- Module Name: FSM_Controller_TB - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;


entity FSM_Controller_TB is
end;

architecture Testbench of FSM_Controller_TB is

constant clk_period : time := 10 ns;

signal Button : std_logic_vector(1 downto 0);
Signal CLK, sysRes, Running_F, watchRes : Std_logic := '0';

signal Stop : BOOLEAN := false;
signal Running_Flag_OK, watchReset_OK, sysReset_OK : BOOLEAN := true;



begin

  FSM_CTRL: entity work.FSM_Controller(Behavioral)
    port map  ( CLK_IN => CLK,
                Buttons => Button,
                sysReset => sysRes,

                Running_Flag => Running_F,
                watchReset => watchRes
              );


  stimulate : process
  begin

      Button <= "00";
      sysRes <= '0';

        wait until rising_edge(CLK);

      Button <= "01";
      sysRes <= '0';

        wait until rising_edge(CLK);

      Button <= "00";
      sysRes <= '0';

        wait until rising_edge(CLK);

      Button <= "00";
      sysRes <= '0';

        wait until rising_edge(CLK);

      Button <= "01";
      sysRes <= '0';

        if Running_F = '0' then
          Running_Flag_OK <= false;
        end if;

        wait until rising_edge(CLK);

      Button <= "00";
      sysRes <= '0';

        wait until rising_edge(CLK);

      Button <= "00";
      sysRes <= '0';

        wait until rising_edge(CLK);

      Button <= "10";
      sysRES <= '0';

        if Running_F = '1' then
          Running_Flag_OK <= false;
        end if;

        wait until rising_edge(CLK);

      Button <= "10";
      sysRES <= '0';

        wait until rising_edge(CLK);

      Button <= "00";
      sysRES <= '0';

        if watchRes = '0' then
          watchReset_OK <= false;
        end if;

        wait until rising_edge(CLK);

      Button <= "01";
      sysRes <= '0';

        wait until rising_edge(CLK);

      Button <= "00";
      sysRes <= '0';

        wait until rising_edge(CLK);

      Button <= "00";
      sysRes <= '1';

        wait until rising_edge(CLK);

      Button <= "00";
      sysRES <= '0';

        if Running_F = '1' then
          sysReset_OK <= False;
        elsif Running_F = '1' then
          sysReset_OK <= False;
        end if;

        wait until rising_edge(CLK);

    stop <= true;
    wait;
  end process stimulate;

  Clock : process
  begin
    while not Stop loop
      CLK <= '0';
      wait for (clk_period/2);
      CLK <= '1';
      wait for (clk_period/2);
    end loop;
    wait;
  end process Clock;

end architecture Testbench;
