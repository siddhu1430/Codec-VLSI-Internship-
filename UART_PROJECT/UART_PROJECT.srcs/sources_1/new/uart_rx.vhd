library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity uart_rx is
    Port ( clk      : in STD_LOGIC;
           rx       : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (7 downto 0);
           received : out STD_LOGIC);
end uart_rx;

architecture Behavioral of uart_rx is
    signal bit_index : integer := 0;
    signal receiving : STD_LOGIC := '0';
    signal data_reg  : STD_LOGIC_VECTOR (7 downto 0);
begin

process(clk)
begin
    if rising_edge(clk) then
        
        if rx = '0' and receiving = '0' then
            receiving <= '1';
            bit_index <= 0;
        end if;

        if receiving = '1' then
            
            if bit_index >= 1 and bit_index <= 8 then
                data_reg(bit_index-1) <= rx;
                
            elsif bit_index = 9 then
                receiving <= '0';
                received <= '1';
            end if;
            
            bit_index <= bit_index + 1;
            
        else
            received <= '0';
        end if;
        
    end if;
end process;

data_out <= data_reg;

end Behavioral;