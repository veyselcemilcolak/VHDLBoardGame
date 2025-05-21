----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:29:33 05/08/2019 
-- Design Name: 
-- Module Name:    vsync_gnrt - Behavioral 
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
USE ieee.std_logic_signed.all ;
USE ieee.std_logic_arith.all ;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vsync_gnrt is
    Port ( en : in  STD_LOGIC;
           slow_clk : in  STD_LOGIC;
           vsync : out  STD_LOGIC;
			  vdsp: OUT std_logic);
end vsync_gnrt;

architecture Behavioral of vsync_gnrt is
	
	
begin		 
	process(slow_clk)
		variable cntr: integer := 1 ; 
		variable vnew : std_logic :='0' ;
		variable tempvdsp: std_logic :='0' ;	
	begin 
		if(slow_clk'event and slow_clk='1') then
			if cntr < 1600 then
			cntr:=cntr+1;
			vnew:='0';
			tempvdsp:='0';
			elsif cntr < 24800 then
			vnew:='1';
			cntr:=cntr+1;
			tempvdsp:='0';
			elsif cntr< 408800 then
			vnew:='1';
			cntr:=cntr+1;
			tempvdsp:='1';
			elsif cntr< 416800 then
			vnew:='1';
			cntr:=cntr+1;
			tempvdsp:='0';
			elsif cntr=416800 then
			cntr:=1;
			vnew:='0';
			tempvdsp:='0';
			end if;
		vsync <= vnew and en ;
			vdsp <= tempvdsp;
			
		end if;
		
	end process;
	 
	

end Behavioral;

