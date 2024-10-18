library Ieee;
use ieee.std_logic_1164.all;
Entity Decoder3 is
 port(
      sel : in  std_logic_vector(2 downto 0) ;
      o   : out std_logic_vector(7 downto 0) 
      );
End Entity;
Architecture Decoder3_behave of Decoder3 is
Begin
    o<=
       "00000001" when sel="000" else
       "00000010" when sel="001" else
       "00000100" when sel="010" else
       "00001000" when sel="011" else
       "00010000" when sel="100" else
       "00100000" when sel="101" else
       "01000000" when sel="110" else
       "10000000" when sel="111"       ;
End Architecture;
