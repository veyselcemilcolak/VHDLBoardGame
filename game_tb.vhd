--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:39:35 05/16/2019
-- Design Name:   
-- Module Name:   C:/Users/kaani/Desktop/ee240 proje/project/game_tb.vhd
-- Project Name:  project
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Rice_Farm_Overall
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_textio.all;
use std.textio.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY game_tb IS
END game_tb;
 
ARCHITECTURE behavior OF game_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Rice_Farm_Overall
    PORT(
         up : IN  std_logic;
         down : IN  std_logic;
         left : IN  std_logic;
         right : IN  std_logic;
         action : IN  std_logic;
         en : IN  std_logic;
         board_clk : IN  std_logic;
         red : OUT  std_logic_vector(2 downto 0);
         green : OUT  std_logic_vector(2 downto 0);
         blue : OUT  std_logic_vector(1 downto 0);
         SSEG_CA : OUT  std_logic_vector(7 downto 0);
         SSEG_AN : OUT  std_logic_vector(3 downto 0);
         vsync : OUT  std_logic;
         hsync : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal up : std_logic := '0';
   signal down : std_logic := '0';
   signal left : std_logic := '0';
   signal right : std_logic := '0';
   signal action : std_logic := '0';
   signal en : std_logic := '0';
   signal board_clk : std_logic := '0';

 	--Outputs
   signal red : std_logic_vector(2 downto 0);
   signal green : std_logic_vector(2 downto 0);
   signal blue : std_logic_vector(1 downto 0);
   signal SSEG_CA : std_logic_vector(7 downto 0);
   signal SSEG_AN : std_logic_vector(3 downto 0);
   signal vsync : std_logic;
   signal hsync : std_logic;

   -- Clock period definitions
   constant board_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Rice_Farm_Overall PORT MAP (
          up => up,
          down => down,
          left => left,
          right => right,
          action => action,
          en => en,
          board_clk => board_clk,
          red => red,
          green => green,
          blue => blue,
          SSEG_CA => SSEG_CA,
          SSEG_AN => SSEG_AN,
          vsync => vsync,
          hsync => hsync
        );

   -- Clock process definitions
   board_clk_process :process
   begin
		board_clk <= '0';
		wait for board_clk_period/2;
		board_clk <= '1';
		wait for board_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for board_clk_period*10;

      -- insert stimulus here 
		
		   up <='0';
         down <='1';
         left <='0';
         right <='0';
         action <='0';
         en <='1'; --
			wait for 100 ms;
			up <='0';
         down <='0';
         left <='0';
         right <='0';
         action <='0';
         en <='1';--
			wait for 100 ms;
			up <='0';
         down <='0';
         left <='0';
         right <='1';
         action <='0';
         en <='1';--
			wait for 100 ms;
			up <='0';
         down <='0';
         left <='0';
         right <='0';
         action <='0';
         en <='1';--
			wait for 100 ms;
			up <='0';
         down <='0';
         left <='0';
         right <='0';
         action <='1';
         en <='1';--
			wait for 100 ms;
			up <='0';
         down <='0';
         left <='0';
         right <='0';
         action <='0';
         en <='1';--
			wait for 100 ms;
			up <='0';
         down <='0';
         left <='0';
         right <='0';
         action <='0';
         en <='0';--
			wait for 100 ms;
			up <='0';
         down <='0';
         left <='0';
         right <='0';
         action <='0';
         en <='1';--
			wait for 100 ms;
			up <='0';
         down <='0';
         left <='0';
         right <='1';
         action <='0';
         en <='1';--
			wait for 100 ms;
			up <='0';
         down <='0';
         left <='0';
         right <='0';
         action <='0';
         en <='1';
			
      wait;
   end process;

	process (board_clk)
    file file_pointer: text is out "write.txt";
    variable line_el: line;
	 variable  cnt : integer :=0;
	 
begin

    if rising_edge(board_clk) then
			if cnt=3 then

        -- Write the time
        write(line_el, now); -- write the line.
        write(line_el, ":"); -- write the line.

        -- Write the hsync
        write(line_el, " ");
        write(line_el, hsync); -- write the line.

        -- Write the vsync
        write(line_el, " ");
        write(line_el, vsync); -- write the line.

        -- Write the red
        write(line_el, " ");
        write(line_el, Red); -- write the line.

        -- Write the green
        write(line_el, " ");
        write(line_el, Green); -- write the line.

        -- Write the blue
        write(line_el, " ");
        write(line_el, Blue); -- write the line.

        writeline(file_pointer, line_el); -- write the contents into the file.
		  cnt:=0;
		  else
		  cnt:=cnt+1;
		  end if;

    end if;
end process;


END;
