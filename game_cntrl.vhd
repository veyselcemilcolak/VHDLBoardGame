----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:20:47 05/16/2019 
-- Design Name: 
-- Module Name:    game_cntrl - Behavioral 
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

entity game_cntrl is
    Port ( left : in  STD_LOGIC;
				right : in  STD_LOGIC;
           up : in  STD_LOGIC;
           down : in  STD_LOGIC;
           action : in  STD_LOGIC;
			  en : in STD_LOGIC;
			  control_clk: in STD_LOGIC;
           x_pos : out  STD_LOGIC_VECTOR (1 downto 0);
           y_pos : out  STD_LOGIC_VECTOR (1 downto 0);
           is_planted : out  STD_LOGIC_VECTOR(8 downto 0) ;
			  seed_cnt : out STD_LOGIC_VECTOR (3 downto 0);
			  harvest_cnt : out STD_LOGIC_VECTOR (3 downto 0);
			  win: out  STD_LOGIC );
end game_cntrl;

architecture Behavioral of game_cntrl is

begin 
	 
process (control_clk)
	
	variable x_temp : std_logic_vector (1 downto 0) := "00";
	variable y_temp : std_logic_vector (1 downto 0) := "00";
	variable plant_temp : STD_LOGIC_VECTOR (8 downto 0) := "000000000";
	variable seed_temp : STD_LOGIC_VECTOR (3 downto 0):="0000";
	variable harvest_temp : STD_LOGIC_VECTOR (3 downto 0):="0000";
	variable win_tmp : STD_LOGIC:= '0'; 
	variable list: integer := 0;
	
	variable right_old :STD_LOGIC:= '0';
   variable left_old : STD_LOGIC:= '0';
   variable up_old : STD_LOGIC:= '0';
   variable down_old : STD_LOGIC:= '0';
   variable action_old : STD_LOGIC:= '0';



begin

	if(control_clk'event and control_clk='0') then
		if(up_old='1' and up='0') then
				if y_temp="00" then
				y_temp:="10";
				else
				y_temp:=y_temp-'1';
				end if;
		elsif(down_old='1' and down='0') then
				if y_temp="10" then
				y_temp:="00";
				else
				y_temp:=y_temp+'1';
				end if;
		elsif(left_old='1' and left='0') then
				if x_temp="00" then
				x_temp:="10";
				else
				x_temp:=x_temp-'1';
				end if;
		elsif(right_old='1' and right='0') then
				if x_temp="10" then
				x_temp:="00";
				else
				x_temp:=x_temp+'1';
				end if;
		elsif(action_old='1' and action='0') then
		
				if (x_temp="00" and y_temp="00") then list :=0;
				elsif(x_temp="01" and y_temp="00") then list :=1;
				elsif(x_temp="10" and y_temp="00") then list :=2;
				elsif(x_temp="00" and y_temp="01") then list :=3;
				elsif(x_temp="01" and y_temp="01") then list :=4;
				elsif(x_temp="10" and y_temp="01") then list :=5;
				elsif(x_temp="00" and y_temp="10") then list :=6;
				elsif(x_temp="01" and y_temp="10") then list :=7;
				elsif(x_temp="10" and y_temp="10") then list :=8;
				end if;
		
				if plant_temp(list)='1' then
				plant_temp(list):='0';
						if harvest_temp="1001" then
						win_tmp:='1';
						else 
							harvest_temp:=harvest_temp+'1';
							seed_temp:=seed_temp-'1';
						end if;
				elsif	plant_temp(list)='0' then
				plant_temp(list):='1';
				seed_temp:=seed_temp+'1';									
				end if;
		end if;
		
		if (win_tmp='1' or en='0' ) then
			x_temp:="00";
			y_temp:="00";
			plant_temp:="000000000";
			seed_temp:="0000";
			harvest_temp:="0000";
			win_tmp:='0';
		end if;
		
	
	x_pos<=x_temp;
	y_pos<=y_temp;
	is_planted<=plant_temp;
	seed_cnt<=seed_temp;
	harvest_cnt<=harvest_temp;
	win<=win_tmp;
	
	right_old := right;
   left_old := left;
   up_old := up;
   down_old := down;
   action_old := action;

	

	end if;
	end process;
end Behavioral;

