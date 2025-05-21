----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:12:36 05/08/2019 
-- Design Name: 
-- Module Name:    hsync_gnrt - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
USE ieee.std_logic_signed.all ;
USE ieee.std_logic_arith.all ;


-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity hsync_gnrt is
    Port ( en : in  STD_LOGIC;
           slow_clk : in  STD_LOGIC;
           hsync : out  STD_LOGIC;
			  hdsp: OUT std_logic);
end hsync_gnrt;

architecture Behavioral of hsync_gnrt is
	
	
begin		 
	process(slow_clk)
		variable cntr: integer := 1 ; 
		variable hnew : std_logic :='0' ;
	   variable temphdsp:std_logic :='0' ;	
	begin 
		if(slow_clk'event and slow_clk='1') then
			if cntr < 96 then
			cntr:=cntr+1;
			hnew:='0';
			temphdsp:='0';
			elsif cntr < 144 then
			hnew:='1';
			cntr:=cntr+1;
			temphdsp:='0';
			elsif cntr< 784 then
			hnew:='1';
			cntr:=cntr+1;
			temphdsp:='1';
			elsif cntr< 800 then
			hnew:='1';
			cntr:=cntr+1;
			temphdsp:='0';
			elsif cntr=800 then
			cntr:=1;
			hnew:='0';
			temphdsp:='0';
			end if;
		
			hsync <= hnew and en ;
			hdsp <= temphdsp;
		end if;
		
	end process;
	 
	

end Behavioral;

