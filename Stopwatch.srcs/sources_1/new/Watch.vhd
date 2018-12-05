----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 04.12.2018 15:35:17
-- Design Name:
-- Module Name: Watch - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Watch is
  Port( Running_Flag_IN : in Std_logic;
        watchReset_IN : in Std_logic;
        sysReset : in Std_logic;
        CLK_IN : in std_logic;

        Seconds_output: out std_logic_vector(5 downto 0);
        Minutes_output : out std_logic_vector(5 downto 0)
      );
end Watch;

architecture Behavioral of Watch is

signal CLK : STD_LOGIC;
signal counter : integer range 0 to 100000000 := 0;
signal Minutes_count, Seconds_count : unsigned(5 downto 0);

begin

  Watch_Comb: process(CLK_IN, sysReset)
  begin
    if(sysReset = '1') then
      Seconds_count <= (others => '0');
      Minutes_count <= (others => '0');
    elsif rising_edge(CLK_IN) then
      if(Running_Flag_IN = '1') then
        if(counter = 100000000) then
          counter <= 0;
          Seconds_count <= Seconds_count + 1;
          if Seconds_count = 59 then
            if Minutes_count = 59 then
              Seconds_count <= (others => '0');
              Minutes_count <= (others => '0');
            else
              Seconds_count <= (others => '0');
              Minutes_count <= Minutes_count + 1;
            end if;
          end if;
        else
          counter <= counter + 1;
        end if;
      elsif watchReset_IN = '1' then
        Seconds_count <= (others => '0');
        Minutes_count <= (others => '0');
      end if;
    end if;
  end process Watch_Comb;

Seconds_output <= std_logic_vector(Seconds_count);
Minutes_output <= std_logic_vector(Minutes_count);

end Behavioral;
