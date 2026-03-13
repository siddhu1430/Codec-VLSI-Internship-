library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity digital_lock is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           input_pass : in STD_LOGIC_VECTOR (3 downto 0);
           unlock : out STD_LOGIC;
           alarm : out STD_LOGIC);
end digital_lock;

architecture Behavioral of digital_lock is
    signal correct_pass : STD_LOGIC_VECTOR (3 downto 0) := "1010";
    signal attempt : INTEGER := 0;
begin

process(clk, reset)
begin
    if reset = '1' then
        unlock <= '0';
        alarm <= '0';
        attempt <= 0;

    elsif rising_edge(clk) then
        if input_pass = correct_pass then
            unlock <= '1';
            alarm <= '0';
            attempt <= 0;
        else
            unlock <= '0';
            attempt <= attempt + 1;
            if attempt = 2 then
                alarm <= '1';
            end if;
        end if;
    end if;
end process;

end Behavioral;