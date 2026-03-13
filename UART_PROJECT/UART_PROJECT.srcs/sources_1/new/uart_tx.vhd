library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity uart_tx is
    Port ( clk      : in STD_LOGIC;
           start    : in STD_LOGIC;
           data_in  : in STD_LOGIC_VECTOR (7 downto 0);
           tx       : out STD_LOGIC;
           done     : out STD_LOGIC);
end uart_tx;

architecture Behavioral of uart_tx is
    signal bit_index : integer := 0;
    signal sending   : STD_LOGIC := '0';
    signal tx_reg    : STD_LOGIC := '1';
begin

process(clk)
begin
    if rising_edge(clk) then
        
        if start = '1' and sending = '0' then
            sending <= '1';
            bit_index <= 0;
        end if;

        if sending = '1' then
            
            if bit_index = 0 then
                tx_reg <= '0'; -- Start bit
                
            elsif bit_index >= 1 and bit_index <= 8 then
                tx_reg <= data_in(bit_index-1);
                
            elsif bit_index = 9 then
                tx_reg <= '1'; -- Stop bit
                
            elsif bit_index = 10 then
                sending <= '0';
                done <= '1';
            end if;
            
            bit_index <= bit_index + 1;
            
        else
            tx_reg <= '1';
            done <= '0';
        end if;
        
    end if;
end process;

tx <= tx_reg;

end Behavioral;