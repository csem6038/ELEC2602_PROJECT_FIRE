LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY proc IS
PORT (
	Data : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	Reset, w : IN STD_LOGIC;
	Clock : IN STD_LOGIC;
	Function_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0); --Added to have a function input to the control unit
	F, Rx, Ry : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	Done : OUT STD_LOGIC;
	BusWires : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END proc;



ARCHITECTURE Behaviour OF proc IS
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
			sel : IN STD_LOGIC;
			chosen_result : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END COMPONENT;

COMPONENT controlunit IS
	 PORT (Clock, Res,w : in std_logic;
		Ain,Gin,Gout,Data : out std_logic; -- Deleted Aout from here as it is not part of the schematic
		
		R0_in, R0_out, R1_in,R1_out,
		R2_in, R2_out, R3_in,R3_out: out std_logic;
		
		
		funct: in std_logic_vector(15 downto 0)

		);
		
END COMPONENT;

SIGNAL Rin, Rout : STD_LOGIC_VECTOR(0 TO 3);
SIGNAL Ain, Gin, Gout : STD_LOGIC;
SIGNAL AddXor, Extern : STD_LOGIC ;
--register outputs
SIGNAL R0, R1, R2, R3 : STD_LOGIC_VECTOR(15 DOWNTO 0) ;
SIGNAL A, ALUout, G : STD_LOGIC_VECTOR(15 DOWNTO 0);
BEGIN

		--Register Declarations--
	regR0 : register16 PORT MAP(Clock, Rin(0), BusWires, R0);
	regR1 : register16 PORT MAP(Clock, Rin(1), BusWires, R1);
	regR2 : register16 PORT MAP(Clock, Rin(2), BusWires, R2);
	regR3 : register16 PORT MAP(Clock, Rin(3), BusWires, R3);
	regG : register16 PORT MAP(Clock, Gin, ALUout, G);
	regA : register16 PORT MAP(Clock, Ain, BusWires, A);
	
	--Tristate Buffer Declarations--
	triR0: trin PORT MAP(R0, Rout(0), BusWires);
	triR1: trin PORT MAP(R1, Rout(1), BusWires);
	triR2: trin PORT MAP(R2, Rout(2), BusWires);
	triR3: trin PORT MAP(R3, Rout(3), BusWires);
	triG : trin PORT MAP(G, Gout, BusWires);
	--triData : trin PORT MAP(Data, Extern, BusWires);
	
	--ALU Declaration--
	ALU : Arithmetic_Logic_Unit PORT MAP(A, BusWires, AddXor, ALUout);
	
	--Control Circuit Declaration--
	cont : controlunit PORT MAP(Clock, Reset, W, Ain, Gin, Gout, Extern, Rin(0), Rout(0), Rin(1), Rout(1),
			Rin(2), Rout(2), Rin(3), Rout(3), Function_in);
	--
END Behaviour;