----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:04:30 04/16/2019 
-- Design Name: 
-- Module Name:    frombcd2ss - Behavioral 
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

entity frombcd2ss is
    Port ( x_pos : in  STD_LOGIC_VECTOR (1 downto 0);
           y_pos : in  STD_LOGIC_VECTOR (1 downto 0);
           seed_cnt : in  STD_LOGIC_VECTOR (3 downto 0) ;
           harvest_cnt : in  STD_LOGIC_VECTOR (3 downto 0);
			  x_ss : out  STD_LOGIC_VECTOR (7 downto 0);
			  y_ss: out  STD_LOGIC_VECTOR (7 downto 0);
			  seed_ss: out  STD_LOGIC_VECTOR (7 downto 0);
			  harv_ss: out  STD_LOGIC_VECTOR (7 downto 0));
end frombcd2ss;

architecture Behavioral of frombcd2ss is

SIGNAL sig_x : STD_LOGIC_VECTOR (6 downto 0);
SIGNAL sig_y : STD_LOGIC_VECTOR (6 downto 0);
SIGNAL sig_seed : STD_LOGIC_VECTOR (6 downto 0);
SIGNAL sig_harv : STD_LOGIC_VECTOR (6 downto 0);
begin

with seed_cnt select
sig_seed <="1000000" when "0000",
"1111001" when "0001",
"0100100" when "0010",
"0110000" when "0011",
"0011001" when "0100",
"0010010" when "0101",
"0000010" when "0110",
"1111000" when "0111",
"0000000" when "1000",
"0010000" when "1001",
"XXXXXXX" when others;

with harvest_cnt select
sig_harv <="1000000" when "0000",
"1111001" when "0001",
"0100100" when "0010",
"0110000" when "0011",
"0011001" when "0100",
"0010010" when "0101",
"0000010" when "0110",
"1111000" when "0111",
"0000000" when "1000",
"0010000" when "1001",
"XXXXXXX" when others;
with x_pos select
sig_x <= "1000000" when "00",
"1111001" when "01",
"0100100" when "10",
"0110000" when "11",
"XXXXXXX" when others;
with y_pos select
sig_y <= "1000000" when "00",
"1111001" when "01",
"0100100" when "10",
"0110000" when "11",
"XXXXXXX" when others;
x_ss <= '1' & sig_x;
y_ss <= '1' & sig_y;
seed_ss <= '1' & sig_seed;
harv_ss <= '1' & sig_harv;
end Behavioral;

