----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:02:20 05/08/2019 
-- Design Name: 
-- Module Name:    frq_dvd - Behavioral 
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
USE ieee.std_logic_signed.all ;
USE ieee.std_logic_arith.all ;
library UNISIM;
use UNISIM.vcomponents.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values


-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY JKFF IS
	PORT ( J: in STD_LOGIC;
			 K: in STD_LOGIC;
			 C: in STD_LOGIC;
			 Q: out STD_LOGIC;
			 CLR: in STD_LOGIC);	
END; 
			 
ARCHITECTURE Behavioral OF JKFF IS
	SIGNAL D: STD_LOGIC;
	SIGNAL S: STD_LOGIC;
	COMPONENT FDCE 
		PORT (Q : out STD_LOGIC;
		 C : in STD_LOGIC;
		 CE : STD_LOGIC;
		 CLR : in STD_LOGIC;
		 D :in STD_LOGIC );
	END COMPONENT;

BEGIN	
		c1: FDCE PORT MAP(S,C,'1','0',D);
		D <= (J and(K xor S)) or (not K  and (J xor S));
		Q<=S;		 
END behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
USE ieee.std_logic_signed.all ;
USE ieee.std_logic_arith.all ;
library UNISIM;
use UNISIM.vcomponents.all;
			 
ENTITY frq_dvd is
    PORT ( sys_clk : in  STD_LOGIC;
          vga : out  STD_LOGIC;
			 vsc: out  STD_LOGIC);
END frq_dvd;

ARCHITECTURE Behavioral of frq_dvd is
	COMPONENT JK_FF 
	PORT ( J: in STD_LOGIC;
			 K: in STD_LOGIC;
			 C: in STD_LOGIC;
			 Q: out STD_LOGIC;
			 CLR: in STD_LOGIC);	
	END COMPONENT; 
	FOR ALL: JK_FF USE ENTITY WORK.JKFF(BEHAVIORAL);
	
	
	SIGNAL T: STD_LOGIC_VECTOR (19 DOWNTO 0);
		
 
BEGIN



z1: JK_FF PORT MAP ('1','1',sys_clk, T(0),'0');
z2: JK_FF PORT MAP ('1','1',T(0), T(1),'0');
z3	: JK_FF PORT MAP ('1','1',T(			1	), T(	2	),'0');
z4	: JK_FF PORT MAP ('1','1',T(			2	), T(	3	),'0');
z5	: JK_FF PORT MAP ('1','1',T(			3	), T(	4	),'0');
z6	: JK_FF PORT MAP ('1','1',T(			4	), T(	5	),'0');
z7	: JK_FF PORT MAP ('1','1',T(			5	), T(	6	),'0');
z8	: JK_FF PORT MAP ('1','1',T(			6	), T(	7	),'0');
z9	: JK_FF PORT MAP ('1','1',T(			7	), T(	8	),'0');
z10	: JK_FF PORT MAP ('1','1',T(			8	), T(	9	),'0');
z11	: JK_FF PORT MAP ('1','1',T(			9	), T(	10	),'0');
z12	: JK_FF PORT MAP ('1','1',T(			10	), T(	11	),'0');
z13	: JK_FF PORT MAP ('1','1',T(			11	), T(	12	),'0');
z14	: JK_FF PORT MAP ('1','1',T(			12	), T(	13	),'0');
z15	: JK_FF PORT MAP ('1','1',T(			13	), T(	14	),'0');
z16	: JK_FF PORT MAP ('1','1',T(			14	), T(	15	),'0');
z17	: JK_FF PORT MAP ('1','1',T(			15	), T(	16	),'0');
z18	: JK_FF PORT MAP ('1','1',T(			16	), T(	17	),'0');
z19	: JK_FF PORT MAP ('1','1',T(			17	), T(	18	),'0');
z20	: JK_FF PORT MAP ('1','1',T(			18	), T(	19	),'0');


vga <= T(1);
vsc<=T(19);



END Behavioral;


