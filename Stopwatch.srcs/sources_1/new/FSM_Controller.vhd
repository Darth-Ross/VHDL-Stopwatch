----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 03.12.2018 16:20:05
-- Design Name:
-- Module Name: FSM_Controller - Behavioral
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

entity FSM_Controller is
  port( CLK_IN : in std_logic;
        sysReset : in std_logic;
        Buttons : in std_logic_vector(1 downto 0);

        Running_Flag : out std_logic;
        watchReset : out std_logic
      );
end FSM_Controller;

architecture Behavioral of FSM_Controller is

  type FSM_STATES is (Init, Running, Running_Hold, Paused, Paused_Hold, Reset);
  signal State, NextState : FSM_STATES;

begin

  FSM_Reg : process(CLK_IN, sysReset)
  begin
      if(sysReset = '1') then
        State <= Init;

      elsif rising_edge(CLK_IN) then
        State <= NextState;
      end if;
  end process FSM_Reg;


  FSM_Comb : process(State, Buttons)
  begin

    case State is

      when Init =>
        Running_Flag <= '0';
        watchReset <= '0';
        NextState <= Paused;

      when paused =>
        watchReset <= '0';
        Running_Flag <= '0';

        if Buttons(0) = '1' then
          NextState <= Running_Hold;
        elsif Buttons(1) = '1' then
          NextState <= Reset;
        else
          NextState <= paused;
        end if;

      when Paused_Hold =>
        watchReset <= '0';
        Running_Flag <= '0';

        if Buttons(0) = '0' then
          NextState <= paused;
        else
          NextState <= Paused_Hold;
        end if;

      when Running =>
        watchReset <= '0';
        Running_Flag <= '1';

        if Buttons(0) = '1' then
          NextState <= Paused_Hold;
        else
          NextState <= Running;
        end if;

      when Running_Hold =>
        watchReset <= '0';
        Running_Flag <= '0';

        if Buttons(0) = '0' then
          NextState <= Running;
        else
          NextState <= Running_Hold;
        end if;

      when Reset =>
        watchReset <= '1';
        Running_Flag <= '0';

        if Buttons(1) = '0' then
          watchReset <= '0';
          NextState <= paused;
        else
          NextState <= Reset;
        end if;

      when others =>
        watchReset <= '0';
        Running_Flag <= '0';
        NextState <= Init;
      end case;

    end process FSM_Comb;
end Behavioral;
