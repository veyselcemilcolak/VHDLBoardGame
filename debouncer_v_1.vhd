----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:22:41 04/15/2019 
-- Design Name: 
-- Module Name:    debouncer_v_1 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
USE ieee.std_logic_arith.all ;
USE ieee.std_logic_signed.all ;
Library UNISIM;
use UNISIM.VComponents.all;

entity debouncer is
    Port ( slowclk : in  STD_LOGIC;
           BTNL : in  STD_LOGIC;
			  BTNR : in  STD_LOGIC;
           BTNU : in  STD_LOGIC;
           BTND : in  STD_LOGIC;
			  BTNS : in  STD_LOGIC;
           left : out  STD_LOGIC;
			  right: out  STD_LOGIC;
			  up : out  STD_LOGIC;
			  down : out  STD_LOGIC;
           action : out  STD_LOGIC);
end debouncer;

architecture Behavioral of debouncer is
 COMPONENT FDCE
		PORT(Q : out STD_LOGIC;
			  C : in STD_LOGIC;
			  CE : STD_LOGIC;
			  CLR : in STD_LOGIC;
		     D :in STD_LOGIC );
	END COMPONENT;	
SIGNAL T: STD_LOGIC_VECTOR(109 DOWNTO 0);

begin

G1	:	FDCE PORT MAP	(T(	0	)	,slowclk,'1','0',BTNL);
G2	:	FDCE PORT MAP	(T(	1	)	,slowclk,'1','0',T(	0	));
G3	:	FDCE	PORT MAP (T(	2	)	,slowclk,'1','0',T(	1	));
G4	:	FDCE PORT MAP	(T(	3	)	,slowclk,'1','0',T(	2	));
G5	:	FDCE PORT MAP	(T(	4	)	,slowclk,'1','0',BTNR);
G6	:	FDCE PORT MAP	(T(	5	)	,slowclk,'1','0',T(	4	));
G7	:	FDCE PORT MAP	(T(	6	)	,slowclk,'1','0',T(	5	));
G8	:	FDCE PORT MAP	(T(	7	)	,slowclk,'1','0',T(	6	));
G9	:	FDCE	PORT MAP (T(	8	)	,slowclk,'1','0',BTNU);
G10 :	FDCE PORT MAP	(T(9)	,slowclk,'1','0',T(	8	));
G11 :	FDCE	PORT MAP (T(	10	)	,slowclk,'1','0',T(	9	));
G12 :	FDCE	PORT MAP (T(	11	)	,slowclk,'1','0',T(	10	));
G13	:	FDCE	PORT MAP (T(	12	)	,slowclk,'1','0',BTND);
G14 :	FDCE PORT MAP	(T(13)	,slowclk,'1','0',T(	12	));
G15 :	FDCE	PORT MAP (T(	14	)	,slowclk,'1','0',T(	13	));
G16 :	FDCE	PORT MAP (T(	15	)	,slowclk,'1','0',T(	14	));
G17:	FDCE	PORT MAP (T(	16)	,slowclk,'1','0',BTNS);
G18 :	FDCE PORT MAP	(T(17)	,slowclk,'1','0',T(	16	));
G19 :	FDCE	PORT MAP (T(	18	)	,slowclk,'1','0',T(	17	));
G20 :	FDCE	PORT MAP (T(	19	)	,slowclk,'1','0',T(	18	));

left <= T(0) AND T(1) AND T (2) AND T(3);
right <= T(4) AND T(5) AND T (6) AND T(7);
up <= T(8) AND T(9) AND T (10) AND T(11);
down<= T(12) AND T(13) AND T (14) AND T(15);
action<= T(16) AND T(17) AND T (18) AND T(19);
end Behavioral;
