library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity digital_lock_tb is
end digital_lock_tb;

architecture Behavioral of digital_lock_tb is

component digital_lock
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           input_pass : in STD_LOGIC_VECTOR (3 downto 0);
           unlock : out STD_LOGIC;
           alarm : out STD_LOGIC);
end component;

signal clk : STD_LOGIC := '0';
signal reset : STD_LOGIC := '0';
signal input_pass : STD_LOGIC_VECTOR (3 downto 0);
signal unlock : STD_LOGIC;
signal alarm : STD_LOGIC;

begin

uut: digital_lock port map (
    clk => clk,
    reset => reset,
    input_pass => input_pass,
    unlock => unlock,
    alarm => alarm
);

clk_process :process
begin
    clk <= '0';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;
end process;

stim_proc: process
begin
    reset <= '1';
    wait for 20 ns;
    reset <= '0';

    -- Correct password
    input_pass <= "1010";
    wait for 40 ns;

    -- Wrong attempt 1
    input_pass <= "0001";
    wait for 40 ns;

    -- Wrong attempt 2
    input_pass <= "0011";
    wait for 40 ns;

    -- Wrong attempt 3 (alarm should activate)
    input_pass <= "0100";
    wait for 40 ns;

    wait;
end process;

end Behavioral;