`timescale 1 ps / 1 ps 
module clock_arm_tb(); 
	logic reset, one_second, change_color, clk, start_clk, fifteen, thirty, fortyfive, timer;
	logic [10:0] x, y; 
	
	clock_arm dut (.*); 
//	
	parameter CLOCK_PERIOD =100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk = ~clk; 
	end // initial
	
	integer i; 
	
	
	initial begin 
		@(posedge clk); 
		reset <= 1; fifteen <= 0; thirty <= 0; fortyfive <= 0; timer <= 0; @(posedge clk); 
		reset <= 0; @(posedge clk);
	
		for (i = 0; i <= 60; i++) begin 
			repeat(500); @(posedge clk);
			one_second <= 1; start_clk <= 1; @(posedge clk); 
			one_second <= 0; @(posedge clk); 
		end 
		
		$stop; 
	end
endmodule 