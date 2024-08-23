// Code is taken from previous lab of course - EE271. 
module DFlipFlop(clk, reset, Q, D);

	input logic clk, reset; 
	input logic Q; 
	output logic D;  

	always_ff @(posedge clk) begin
		D = reset ? 1'b0 : Q;
	end
endmodule 