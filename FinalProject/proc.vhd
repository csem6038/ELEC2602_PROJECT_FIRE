LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY proc IS
--PORT (
--
--	Data : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
--	Reset, w : IN STD_LOGIC;
--	Clock : IN STD_LOGIC;
--	Function_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0); --Added to have a function input to the control unit
--	F, Rx, Ry : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
--	Done : OUT STD_LOGIC;
--	BusWires : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0));
--	
--END proc;

PORT (

	--Data : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	--Reset, w : IN STD_LOGIC;
	SW : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
	LEDR: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	--LEDG: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7 : OUT STD_LOGIC_VECTOR(6 downto 0);
	KEY0,KEY1,KEY2,KEY3 : IN STD_LOGIC;
	--Function_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0); --Added to have a function input to the control unit
	--F, Rx, Ry : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	--Done : INOUT STD_LOGIC; -- lel get kekd doesnt do shit
	Count : INOUT STD_LOGIC_VECTOR(15 downto 0);
	BusWires : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0)
);
END proc;



ARCHITECTURE Behaviour OF proc IS

COMPONENT PC IS
PORT (  clk, reset, nextCount: IN std_logic;
        PC_out: OUT std_logic_vector(15 DOWNTO 0));
END COMPONENT;


COMPONENT progMem16 IS -- n-bit register

	PORT (
		clock        : in std_logic;
		data_in      : in std_logic_vector (15 downto 0);
		write_addr   : in std_logic_vector (15 downto 0);
		read_addr    : in std_logic_vector (15 downto 0);
		write_enable : in std_logic;
		data_out     : out std_logic_vector (15 downto 0));

  END COMPONENT;

COMPONENT register16 IS -- n-bit register
	PORT (Clk, Enable: IN STD_LOGIC;
			Data_in: IN STD_LOGIC_VECTOR(15 downto 0);
			Data_out : OUT STD_LOGIC_VECTOR(15 downto 0));
END COMPONENT;

COMPONENT trin IS  -- tri-state buffer (or use MUX)
	PORT ( A : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		enable : IN STD_LOGIC;
		Q : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END COMPONENT;
	
COMPONENT Arithmetic_Logic_Unit IS  -- n-bit adder/sub
	PORT( num1, num2 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			sel : IN STD_LOGIC_VECTOR(3 downto 0);
			chosen_result : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END COMPONENT;

COMPONENT hexdecode IS  -- n-bit adder/sub
	PORT ( A : IN std_logic_vector(3 downto 0);
			D : OUT std_logic_vector(0 to 6));
			
END COMPONENT;

COMPONENT controlunit IS
	 PORT (Clock, Res,w : in std_logic;
		Ain,Gin,Gout,Data,Done : out std_logic; -- Deleted Aout from here as it is not part of the schematic
		
		R0_in, R0_out, R1_in,R1_out,
		R2_in, R2_out, R3_in,R3_out : out std_logic;
		ALU: out std_logic_vector(3 downto 0);
		
		
		funct: in std_logic_vector(15 downto 0)

		);
		
END COMPONENT;

SIGNAL Rin, Rout : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL Ain, Gin, Gout : STD_LOGIC;
SIGNAL Data : STD_LOGIC ;
SIGNAL ALUselect : STD_LOGIC_VECTOR(3 downto 0);

--register outputs
SIGNAL R0, R1, R2, R3 : STD_LOGIC_VECTOR(15 DOWNTO 0) ;
SIGNAL A, ALUout, G : STD_LOGIC_VECTOR(15 DOWNTO 0);
signal Clock : std_logic ;
signal Reset : std_logic;
signal W : std_logic;
signal Function_in : std_logic_vector(15 downto 0);
--signal BusWires : STD_LOGIC_VECTOR(15 DOWNTO 0);
signal F, Rx, Ry : std_logic;
signal RAMout : STD_LOGIC_VECTOR(15 downto 0);
signal BLANK : STD_LOGIC_VECTOR(15 downto 0);
signal sample,values: STD_LOGIC_VECTOR(15 downto 0);
--signal count: STD_LOGIC_VECTOR(15 downto 0);
signal Done: std_logic;
signal display1 : std_logic_vector(15 downto 0);
signal display2 : std_logic_vector(15 downto 0);
signal multiclock: std_logic;
ATTRIBUTE keep : boolean;
ATTRIBUTE keep of Function_in,Done,Extern,count,Rin,R0,R1,Rin,Rout,Data : SIGNAL IS true;
signal tick: std_logic;
BEGIN
	--Rin <= SW(15 downto 11);
	
	--R0<="0000000000000000";

	--attribute keep: boolean;
	
	
	Clock <= KEY0;
	W <= SW(16);
	Reset <= SW(17);

	BLANK <= "0000000000000000";
	sample <= "0001000001000100";
	
	multiclock <= Done;
	
	RAM : progMem16 PORT MAP(Clock,BLANK,BLANK,count,'0',RAMout);
	pcounter : PC PORT MAP(multiclock,Reset,Done,count);
	
	
	--Function_in <= SW(15 downto 0);

	Function_in <= RAMout;
	--data <='1';
	
		--Register Declarations--
	regR0 : register16 PORT MAP(Clock, Rin(0), BusWires, R0);
	regR1 : register16 PORT MAP(Clock, Rin(1), BusWires, R1);
	regR2 : register16 PORT MAP(Clock, Rin(2), BusWires, R2);
	regR3 : register16 PORT MAP(Clock, Rin(3), BusWires, R3);
	regG : register16 PORT MAP(Clock, Gin, ALUout, G);
	regA : register16 PORT MAP(Clock, Ain, BusWires, A);
	--regI : register16 PORT MAP(Clock, )

display1 <= R0 WHEN KEY1='0' ELSE R2;

display2 <= R1 WHEN KEY1='0' ELSE R3;
	
	hexdec0 : hexdecode PORT MAP(display1 (15 downto 12),HEX3);
	hexdec1 : hexdecode PORT MAP(display1 (11 downto 8),HEX2);
	hexdec2 : hexdecode PORT MAP(display1 (7 downto 4),HEX1);
	hexdec3 : hexdecode PORT MAP(display1 (3 downto 0),HEX0);
	
	hexdec4 : hexdecode PORT MAP(display2 (15 downto 12),HEX7);
	hexdec5 : hexdecode PORT MAP(display2 (11 downto 8),HEX6);
	hexdec6 : hexdecode PORT MAP(display2 (7 downto 4),HEX5);
	hexdec7 : hexdecode PORT MAP(display2 (3 downto 0),HEX4);


	--
	LEDR <= BusWires;--BusWires;
	--LEDG <= R0;
	--Tristate Buffer Declarations--
	triR0: trin PORT MAP(R0, Rout(0), BusWires);
	triR1: trin PORT MAP(R1, Rout(1), BusWires);
	triR2: trin PORT MAP(R2, Rout(2), BusWires);
	triR3: trin PORT MAP(R3, Rout(3), BusWires);
	triG : trin PORT MAP(G, Gout, BusWires);
	triD : trin PORT MAP(Function_in(15 downto 0), data, BusWires);  --always on lel
	--triData : trin PORT MAP(Data, Extern, BusWires);
	
	--ALU Declaration--
	ALU : Arithmetic_Logic_Unit PORT MAP(A, BusWires, ALUselect, ALUout);
	
	--Control Circuit Declaration--
	cont : controlunit PORT MAP(Clock, Reset, W, Ain, Gin, Gout, Data,Done, Rin(0), Rout(0), Rin(1), Rout(1),
			Rin(2), Rout(2), Rin(3), Rout(3),ALUselect,Function_in);
	--
END Behaviour;