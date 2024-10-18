Library Ieee;
Use Ieee.Std_Logic_1164.All;
Use Ieee.Std_Logic_Arith.All;
Entity IR_Decode is
      Port(
		      INP   : In  Std_logic_vector(7 downto 0 ) ;
				Load  : In  Std_logic                     ;
				HOL   : In  Std_logic                     ;
				LEDO  : Out Std_logic_vector(7 downto 0 ) ;
				Dig1  : Out Std_logic_vector(6 downto 0 ) ;
				Dig2  : Out Std_logic_vector(6 downto 0 ) ;
				Dig3  : Out Std_logic_vector(6 downto 0 ) ;
				Dig4  : Out Std_logic_vector(6 downto 0 ) ;
				Dig5  : Out Std_logic_vector(6 downto 0 ) ;
				Clk   : In  Std_logic   
			  );
End Entity;
Architecture IR_Decode_Behave Of IR_Decode is
Component Clock_controll_50MHZ_T_50HZ is 
  port(
        clkin   : in  std_logic     ;
        EN      : in  std_logic     ;
        reset   : in  std_logic     ;
        clkout  : out std_logic     
       );
End Component;
Component  CONVERTER is
port(
     INS    : in  std_logic_vector(15 downto 0)  ;
	  datadig1 : out integer  range 0 to 9          ;
	  datadig2 : out integer  range 0 to 9          ;
	  datadig3 : out integer  range 0 to 9          ;
	  datadig4 : out integer  range 0 to 9          ;
	  datadig5 : out integer  range 0 to 9          
	  );
End Component;
Component Decoder3 is
 port(
      sel : in  std_logic_vector(2 downto 0) ;
      o   : out std_logic_vector(7 downto 0) 
      );
End Component;
Component  IR_16 is
port(
     inir  : in   std_logic_vector(15 downto 0);
	  outir : out  std_logic_vector(15 downto 0);
	  clk   : in   std_logic                    ;
	  load  : in   std_logic                     
	  );
End Component;
Component Disp_CA is
  Port(
       datadig1 : in  integer  range 0 to 9          ;
       datadig2 : in  integer  range 0 to 9          ;
       datadig3 : in  integer  range 0 to 9          ;
    	 datadig4 : in  integer  range 0 to 9          ;
       datadig5 : in  integer  range 0 to 9          ;
       Clk      : in  std_logic                      ;
       dig1     : out std_logic_vector(6 downto 0)   ;
       dig2     : out std_logic_vector(6 downto 0)   ;
    	 dig3     : out std_logic_vector(6 downto 0)   ;
       dig4     : out std_logic_vector(6 downto 0)   ;
       dig5     : out std_logic_vector(6 downto 0)   
       );  
End Component;
Signal LTemp_Data,HTemp_Data,Data_dec8              : Std_logic_vector(7 Downto 0):="00000000" ;--Low & High 8bit Data & Decoded Data
Signal datadig1,datadig2,datadig3,datadig4,datadig5 : integer  range 0 to 9                    ;--Signals to connect DISP AND CONVERTER
Signal Clk0    : Std_logic                                                                     ;--Controller Clk 
Signal IR_datao,IR_Datain,Data_dec16 : Std_logic_vector(15 downto 0):="0000000000000000"       ;--IN/OUT Data for IR & Decoded Data 16bit 
Begin
CCC : Clock_controll_50MHZ_T_50HZ Port Map (Clk,'1','0',Clk0);
    Process(Clk) 
	      Begin 
			     if clk'event and clk='1' then 
				     If load='1' then 
					     If Hol='0' then 
						     LTemp_Data <= inp ;
						  Elsif HOL='1' Then 
						     HTemp_Data <= inp ;
						  End If;
					   End If;
				      IR_Datain <= HTemp_Data & LTemp_Data ;
					End If;
		End Process;
IR1  : IR_16 Port map (IR_Datain ,IR_datao,clk,Load);
DEc  : Decoder3 port map (IR_datao(14 downto 12),Data_dec8);
Data_dec16 <= "00000000" & Data_dec8;
Conv : CONVERTER Port Map (Data_dec16,datadig1,datadig2,datadig3,datadig4,datadig5);
Dis  : Disp_CA  Port Map (datadig1,datadig2,datadig3,datadig4,datadig5,Clk0,Dig1,Dig2,Dig3,Dig4,Dig5);
LEDO <= Data_dec8 ; 
End IR_Decode_Behave;