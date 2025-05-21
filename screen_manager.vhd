----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:22:31 05/16/2019 
-- Design Name: 
-- Module Name:    screen_manager - Behavioral 
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
use UNISIM.VComponents.all;

entity screen_manager is
    Port ( hdsp : in  STD_LOGIC;
           vdsp : in  STD_LOGIC;
           plant_data : in  STD_LOGIC_VECTOR (8 downto 0);
           win_data : in  STD_LOGIC;
           x_data : in  STD_LOGIC_VECTOR (1 downto 0);
           y_data : in  STD_LOGIC_VECTOR (1 downto 0);
           control_clk : in  STD_LOGIC;
           red : out  STD_LOGIC_VECTOR (2 downto 0);
           green : out  STD_LOGIC_VECTOR (2 downto 0);
           blue : out  STD_LOGIC_VECTOR (1 downto 0));
end screen_manager;

architecture Behavioral of screen_manager is

begin

process(control_clk)
		
		variable hcnt: integer :=1;
		variable vcnt: integer :=1;
		variable rtemp : STD_LOGIC_VECTOR (2 downto 0):="000";
      variable gtemp : STD_LOGIC_VECTOR (2 downto 0):="000";
      variable btemp : STD_LOGIC_VECTOR (1 downto 0):="00";
		variable xnum: integer :=0;
		variable ynum: integer :=0;
		
	
	begin 
		
		if(control_clk'event and control_clk = '1') then
			
			if (hdsp='1' and vdsp='1') then
					
					if x_data="00" then xnum:=0;
					elsif x_data="01" then xnum:=1;
					elsif x_data="10" then xnum:=2;
					elsif x_data="11" then xnum:=3;
					end if;
					
					if y_data="00" then ynum:=0;
					elsif y_data="01" then ynum:=1;
					elsif y_data="10" then ynum:=2;
					elsif y_data="11" then ynum:=3;
					end if;
				
					
					if( (((hcnt<21)or (hcnt>210 and hcnt<226)) or ((hcnt>415 and hcnt<431) or (hcnt>620))) or (((vcnt<31)or (vcnt>160 and vcnt<176)) or ((vcnt>305 and vcnt<321) or (vcnt>450)))) then
						if (((hcnt>205 * xnum + 5 and hcnt <205*xnum+21) and (vcnt>145*ynum+15 and vcnt<145*ynum+31))or ((hcnt>205*xnum+5 and hcnt<205*xnum+21) and (vcnt>145*ynum+160 and vcnt<145*ynum+176))or((hcnt>205*xnum+210 and hcnt<205*xnum+226) and (vcnt>145*ynum+15 and vcnt<145*ynum+31))or((hcnt>205*xnum+210 and hcnt<205*xnum+226) and (vcnt>145*ynum+160 and vcnt<145*ynum+176)))then
						  rtemp:="111";
						  gtemp:="000";
						  btemp:="00";
						else 
						  rtemp:="000";
						  gtemp:="111";
						  btemp:="11";
						end if;
						
	
					end if;
					
					loop1: FOR j IN 0 TO 2 LOOP
						loop2: FOR i IN 0 TO 2 LOOP
							if(( 145*j +30< vcnt and 145*j +161>vcnt) and (205*i +20 < hcnt and 205*i +210>hcnt)) then
							   if plant_data(3*j+i)='1' then
										if (hcnt mod 10  = 0) or (hcnt mod 10  = 1) then
											rtemp:="010";
											gtemp:="001";
											btemp:="00";
										
										else
											rtemp:="111";
											gtemp:="111";
											btemp:="11";
										end if;
									
								elsif	plant_data(3*j+i)='0' then
									rtemp:="000";
									gtemp:="111";
									btemp:="00";
								else
									rtemp:="000";
									gtemp:="000";
									btemp:="00";
								end if;	
							end if;
						END LOOP loop2;
					END LOOP loop1;		
									

				
				
				
				if( vcnt= 480 and hcnt =640) then
					vcnt:=1;
					hcnt:=1;
				elsif hcnt =640 then
					vcnt:=vcnt+1;
					hcnt:=1;
				else 
				   hcnt:=hcnt+1;
				end if;
			
			else
				rtemp := "000";
				gtemp := "000";
				btemp := "00" ;  
			end if;  
			
			
			red<=rtemp;
			green<=gtemp;
			blue<=btemp;
			
		
		end if;
	end process;




end Behavioral;

