----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:28:51 05/16/2019 
-- Design Name: 
-- Module Name:    Rice_Farm_Overall - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Rice_Farm_Overall is
    Port ( up : in  STD_LOGIC;
           down : in  STD_LOGIC;
           left : in  STD_LOGIC;
           right : in  STD_LOGIC;
           action : in  STD_LOGIC;
           en : in  STD_LOGIC;
           board_clk : in  STD_LOGIC;
           red : out  STD_LOGIC_VECTOR (2 downto 0);
           green : out  STD_LOGIC_VECTOR (2 downto 0);
           blue : out  STD_LOGIC_VECTOR (1 downto 0);
           SSEG_CA : out  STD_LOGIC_VECTOR (7 downto 0);
           SSEG_AN : out  STD_LOGIC_VECTOR (3 downto 0);
           vsync : out  STD_LOGIC;
           hsync : out  STD_LOGIC); 
end Rice_Farm_Overall;

architecture Behavioral of Rice_Farm_Overall is

COMPONENT frqdvd
PORT ( sys_clk : in  STD_LOGIC;
      vga : out  STD_LOGIC;
		vsc : out  STD_LOGIC);
END COMPONENT;
FOR C1: frqdvd USE ENTITY WORK.frq_dvd(BEHAVIORAL);

COMPONENT DBNC
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
end COMPONENT;
FOR C2: DBNC USE ENTITY WORK.debouncer(BEHAVIORAL);

COMPONENT ctrl 
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
end COMPONENT;
FOR C3: ctrl USE ENTITY WORK.game_cntrl(BEHAVIORAL);

COMPONENT SM
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
end COMPONENT;
FOR C4: SM USE ENTITY WORK.screen_manager(BEHAVIORAL);


COMPONENT HS 
    Port ( en : in  STD_LOGIC;
           slow_clk : in  STD_LOGIC;
           hsync : out  STD_LOGIC;
			  hdsp: OUT std_logic);
end COMPONENT;
FOR C5: HS USE ENTITY WORK.hsync_gnrt(BEHAVIORAL);


COMPONENT VS 
    Port ( en : in  STD_LOGIC;
           slow_clk : in  STD_LOGIC;
           vsync : out  STD_LOGIC;
			  vdsp: OUT std_logic);
end COMPONENT;
FOR C6: VS USE ENTITY WORK.vsync_gnrt(BEHAVIORAL);


COMPONENT BCD2SS 
    Port ( x_pos : in  STD_LOGIC_VECTOR (1 downto 0);
           y_pos : in  STD_LOGIC_VECTOR (1 downto 0);
           seed_cnt : in  STD_LOGIC_VECTOR (3 downto 0) ;
           harvest_cnt : in  STD_LOGIC_VECTOR (3 downto 0);
			  x_ss : out  STD_LOGIC_VECTOR (7 downto 0);
			  y_ss: out  STD_LOGIC_VECTOR (7 downto 0);
			  seed_ss: out  STD_LOGIC_VECTOR (7 downto 0);
			  harv_ss: out  STD_LOGIC_VECTOR (7 downto 0));
end COMPONENT;
FOR C7: BCD2SS USE ENTITY WORK.frombcd2ss(BEHAVIORAL);


COMPONENT SSEG 
    port( 
		MY_CLK 	: in  STD_LOGIC;
		DIGIT0  : in  STD_LOGIC_VECTOR (7 downto 0);
		DIGIT1  : in  STD_LOGIC_VECTOR (7 downto 0);
		DIGIT2  : in  STD_LOGIC_VECTOR (7 downto 0);
		DIGIT3  : in  STD_LOGIC_VECTOR (7 downto 0);
		SSEG_CA : out STD_LOGIC_VECTOR (7 downto 0);
		SSEG_AN : out STD_LOGIC_VECTOR (3 downto 0)
	);
end COMPONENT;
FOR C8: SSEG USE ENTITY WORK.nexys3_sseg_driver(BEHAVIORAL);

SIGNAL slowedclk,upb,downb,leftb,rightb,actionb,w,hdsp,vdsp,verysc: std_logic ;
SIGNAL x,y: std_logic_vector(1 downto 0);
SIGNAL plant: std_logic_vector(8 downto 0);
SIGNAL seed, harvest: std_logic_vector(3 downto 0); 
SIGNAL xss, yss, seedss, harvss: std_logic_vector(7 downto 0);

begin

C1: frqdvd port map(board_clk,slowedclk,verysc);
C2: DBNC port map (verysc, left, right, up, down, action,leftb, rightb, upb, downb, actionb);
C3: ctrl port map (leftb, rightb, upb, downb, actionb,en, slowedclk,x,y,plant,seed,harvest,w);
C4: SM port map (hdsp,vdsp,plant,w,x,y,slowedclk,red,green,blue);
C5: HS port map (en, slowedclk,hsync,hdsp);
C6: VS port map  (en, slowedclk,vsync,vdsp);
C7: BCD2SS port map (x,y,seed, harvest,xss, yss, seedss, harvss);
C8: SSEG port map (board_clk, harvss, seedss, yss, xss,sseg_ca,sseg_an);
end Behavioral; 

