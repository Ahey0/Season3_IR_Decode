library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
Entity IR_16 is
port(
   inir  : in   std_logic_vector(15 downto 0);
	  outir : out  std_logic_vector(15 downto 0);
	  clk   : in   std_logic                    ;
	  load  : in   std_logic                     
	  );
End Entity;
Architecture IR_16_behave of IR_16 is
signal S_IR : std_logic_vector(15 downto 0):="0010000000000100";   
Begin
   process (clk)
     begin
          if clk'event and clk='1' then
             if  load='1' then
				     S_IR <= inir ;
				 end if;
			 end if;
		end process;
outir<=S_IR;
end Architecture;		