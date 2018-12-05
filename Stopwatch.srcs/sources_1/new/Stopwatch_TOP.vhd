----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 04.12.2018 17:26:16
-- Design Name:
-- Module Name: Stopwatch_TOP - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Stopwatch_TOP is
  Port( CLK : in std_logic;
        Buttons_in : in std_logic_vector(1 downto 0);
        sysRes : in std_logic;

        Display_output : out std_logic_vector(6 downto 0);
        Display_select : out STD_LOGIC_VECTOR(3 downto 0)
      );
end Stopwatch_TOP;

architecture Behavioral of Stopwatch_TOP is

signal Running_F, watchRes : std_logic;
signal seconds, minutes : std_logic_vector(5 downto 0);

signal BCD_OS, BCD_OM, BCD_TS, BCD_TM : STD_LOGIC_VECTOR(3 downto 0);
signal a0, b0, c0, d0, e0, f0, g0 : STD_LOGIC;
signal a1, b1, c1, d1, e1, f1, g1 : STD_LOGIC;
signal a2, b2, c2, d2, e2, f2, g2 : STD_LOGIC;
signal a3, b3, c3, d3, e3, f3, g3 : STD_LOGIC;

begin

FSM_Ctrl: entity work.FSM_Controller(Behavioral)
port map( CLK_IN => CLK,
          sysReset => sysRes,
          Buttons => Buttons_in,

          Running_Flag => Running_F,
          watchReset => watchRes
        );

Watch0: entity work.Watch(Behavioral)
port map( CLK_IN => CLK,
          Running_Flag_IN => Running_F,
          watchReset_IN => watchRes,
          sysReset => sysRes,

          Seconds_output => seconds,
          Minutes_output => Minutes
        );

BintoBCD0: entity work.BinToBCD(Behavioral)
port map(   BIN_in => Seconds,

            BCD_Ones => BCD_OS,
			      BCD_Tens => BCD_TS
		    );

BintoBCD1: entity work.BinToBCD(Behavioral)
port map(   BIN_in => Minutes,

            BCD_Ones => BCD_OM,
			      BCD_Tens => BCD_TM
		    );


BCDto7SEG0 : entity work.BCDto7SEG(Behavioral)
port map( CA => a0,
      	  CB => b0,
      	  CC => c0,
      	  CD => d0,
      		CE => e0,
      		CF => f0,
      		CG => g0,

      		A => BCD_OS(0),
      		B => BCD_OS(1),
      		C => BCD_OS(2),
      		D => BCD_OS(3)
        );

BCDto7SEG1 : entity work.BCDto7SEG(Behavioral)
port map(	CA => a1,
      		CB => b1,
      		CC => c1,
      		CD => d1,
      		CE => e1,
      		CF => f1,
      		CG => g1,

      		A => BCD_TS(0),
      		B => BCD_TS(1),
      		C => BCD_TS(2),
      		D => BCD_TS(3)
        );

BCDto7SEG2 : entity work.BCDto7SEG(Behavioral)
port map(	CA => a2,
      		CB => b2,
      		CC => c2,
      	  CD => d2,
         	CE => e2,
      		CF => f2,
      		CG => g2,

      		A => BCD_OM(0),
      		B => BCD_OM(1),
      		C => BCD_OM(2),
      		D => BCD_OM(3)
        );

BCDto7SEG3 : entity work.BCDto7SEG(Behavioral)
port map(	CA => a3,
      		CB => b3,
      		CC => c3,
      		CD => d3,
      		CE => e3,
      		CF => f3,
      		CG => g3,

      		A => BCD_TM(0),
    			B => BCD_TM(1),
  				C => BCD_TM(2),
					D => BCD_TM(3)
        );

Display_D : entity work.DisplayDriver(Behavioral)
port map(	AN(0) => Display_select(0),
      		AN(1) => Display_select(1),
      		AN(2) => Display_select(2),
      		AN(3) => Display_select(3),

    	   	Display_Out(0) => Display_Output(0),
    			Display_Out(1) => Display_Output(1),
					Display_Out(2) => Display_Output(2),
  				Display_Out(3) => Display_Output(3),
    			Display_Out(4) => Display_Output(4),
  				Display_Out(5) => Display_Output(5),
					Display_Out(6) => Display_Output(6),

  				Display_IN0(0) => a0,
      		Display_IN0(1) => b0,
    			Display_IN0(2) => c0,
					Display_IN0(3) => d0,
					Display_IN0(4) => e0,
      		Display_IN0(5) => f0,
      		Display_IN0(6) => g0,

    			Display_IN1(0) => a1,
    			Display_IN1(1) => b1,
  				Display_IN1(2) => c1,
      		Display_IN1(3) => d1,
      		Display_IN1(4) => e1,
    			Display_IN1(5) => f1,
    			Display_IN1(6) => g1,

      		Display_IN2(0) => a2,
    			Display_IN2(1) => b2,
  				Display_IN2(2) => c2,
    			Display_IN2(3) => d2,
    			Display_IN2(4) => e2,
  				Display_IN2(5) => f2,
  				Display_IN2(6) => g2,

					Display_IN3(0) => a3,
      		Display_IN3(1) => b3,
      		Display_IN3(2) => c3,
    			Display_IN3(3) => d3,
					Display_IN3(4) => e3,
    			Display_IN3(5) => f3,
  			  Display_IN3(6) => g3,

      		CLK_IN => CLK
        );


end Behavioral;
