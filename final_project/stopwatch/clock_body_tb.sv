`timescale 1 ps / 1 ps 
module clock_body_tb(); 
	logic clk, reset, clk_done; 
	logic [10:0] x, y; 
	
	clock_body dut (.*);
	
	initial begin
		clk <= 0; 
		forever #(100/2) clk <= ~clk; 
	end
	
	initial begin 
		reset <= 1; @(posedge clk); 
		reset <= 0; @(posedge clk); 
		
		repeat(500); @(posedge clk); 
		
		$stop; 
	end
endmodule 