library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity uart_tb is
end uart_tb;

architecture Behavioral of uart_tb is

component uart_tx
    Port ( clk      : in STD_LOGIC;
           start    : in STD_LOGIC;
           data_in  : in STD_LOGIC_VECTOR (7 downto 0);
           tx       : out STD_LOGIC;
           done     : out STD_LOGIC);
end component;

component uart_rx
    Port ( clk      : in STD_LOGIC;
           rx       : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (7 downto 0);
           received : out STD_LOGIC);
end component;

signal clk       : STD_LOGIC := '0';
signal start     : STD_LOGIC := '0';
signal data_in   : STD_LOGIC_VECTOR (7 downto 0) := "01000001"; -- ASCII A
signal tx        : STD_LOGIC;
signal done      : STD_LOGIC;
signal data_out  : STD_LOGIC_VECTOR (7 downto 0);
signal received  : STD_LOGIC;

begin

tx_unit: uart_tx port map(clk, start, data_in, tx, done);
rx_unit: uart_rx port map(clk, tx, data_out, received);

clk_process: process
begin
    clk <= '0';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;
end process;

stimulus: process
begin
    wait for 20 ns;
    start <= '1';
    wait for 20 ns;
    start <= '0';
    
    wait for 500 ns;
    wait;
end process;

end Behavioral;