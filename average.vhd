library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity average is port(
    clk : in std_logic;
    ip : in std_logic_vector(7 downto 0);
    op : out std_logic_vector(7 downto 0));
end entity; 

architecture rtl of average is 

type t_register is array (0 to 7) of unsigned(7 downto 0); 

signal shift_reg : t_register :=(others=>(others=>'0'));
signal accumulator : unsigned(10 downto 0):=(others=>'0');
   
begin 

shift : process(clk)
begin 
    if rising_edge(clk)then 
        shift_reg <= unsigned(ip) & shift_reg(shift_reg'low to shift_reg'high-1);
    end if;
end process;

accum : process(clk)
begin
    if rising_edge(clk) then 
       accumulator <= resize(shift_reg(0),11) + resize(shift_reg(1),11)+ resize(shift_reg(2),11) + resize(shift_reg(3),11)
                        +resize(shift_reg(4),11)+ resize(shift_reg(5),11)+ resize(shift_reg(6),11) +resize(shift_reg(7),11);   
    end if;
end process;

op <= std_logic_vector(accumulator(10 downto 3));

end architecture; 