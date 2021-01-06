----------------------------------------------------------------------------------
-- Demux Test-Bench
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

library std; -- for Printing
use std.textio.all;
use ieee.std_logic_textio.all;

entity demux_tb is
	
	constant CLK_PERIOD : time := 10 ns;
	constant stop_clock : boolean := false;
	
	signal clk :    std_logic;
	signal reset :    std_logic;
	signal a_t,a_f: std_logic_vector(1 downto 0);
	signal b_t,b_f: std_logic_vector(1 downto 0);
	signal c_t,c_f: std_logic_vector(1 downto 0);
	signal a_ack, sel_ack, selector_t, selector_f: std_logic;
	signal complete_B, complete_C : std_logic;
end demux_tb;

architecture beh of demux_tb is
begin
	demux_test : entity work.demux
	generic map(
		DATA_WIDTH => 2
	)
	port map(
		rst           => reset,
		-- Input port
		inA_data_t    => a_t,
		inA_data_f    => a_f,
		inA_ack       => a_ack,
		-- Select port 
		inSel_ack     => sel_ack,
		selector_t    => selector_t,
		selector_f    => selector_f,
		-- Output channel 1
		outB_data_t   => b_t,
		outB_data_f   => b_f,
		outB_ack      => complete_B,
		-- Output channel 2
		outC_data_t   => c_t,
		outC_data_f   => c_f,
		outC_ack      => complete_C
	);
	
	cd_outB : entity work.completion_detector
	generic map ( DATA_WIDTH => 2)
	port map(
		data_t => b_t,
		data_f => b_f,
		rst => reset,
		complete => complete_B
	);
	
	cd_outC : entity work.completion_detector
	generic map ( DATA_WIDTH => 2)
	port map(
		data_t => c_t,
		data_f => c_f,
		rst => reset,
		complete => complete_C
	);
	
	demux_stimuli : process
	begin		
		wait until rising_edge(clk);
		a_t <= "00";
		a_f <= "00";
		selector_t <='0';
		selector_f <='0';
		
		wait until rising_edge(clk);
		a_t <= "00";
		a_f <= "11";
		wait for 2 ns;
		selector_t <= '0';
		selector_f <= '1';
		wait until a_ack = '1';
		a_t <= "00";
		a_f <= "00";
		selector_t <= '0';
		selector_f <= '0';
		wait until a_ack = '0';
		
		wait until rising_edge(clk);
		a_t <= "01";
		a_f <= "10";
		wait for 2 ns;
		selector_t <= '1';
		selector_f <= '0';
		wait until a_ack = '1';
		a_t <= "00";
		a_f <= "00";
		selector_t <= '0';
		selector_f <= '0';
		wait until a_ack = '0';
		
		wait until rising_edge(clk);
		a_t <= "10";
		a_f <= "01";
		wait for 2 ns;
		selector_t <= '0';
		selector_f <= '1';
		wait until a_ack = '1';
		a_t <= "00";
		a_f <= "00";
		selector_t <= '0';
		selector_f <= '0';
		wait until a_ack = '0';
		
		wait until rising_edge(clk);
		a_t <= "11";
		a_f <= "00";
		wait for 2 ns;
		selector_t <= '1';
		selector_f <= '0';
		wait until a_ack = '1';
		a_t <= "00";
		a_f <= "00";
		selector_t <= '0';
		selector_f <= '0';
		wait until a_ack = '0';
		
		wait;
	end process;
	
	generate_clk : process
	begin
		reset <= '1';
		clk <= '0';
		wait for CLK_PERIOD;
		reset <= '0';
		
		while not stop_clock loop
			clk <= '0', '1' after CLK_PERIOD / 2;
			wait for CLK_PERIOD;
		end loop;
		wait;
	end process;
	
end architecture;