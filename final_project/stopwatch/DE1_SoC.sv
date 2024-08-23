module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW,
					 CLOCK_50, VGA_R, VGA_G, VGA_B, VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;

	input CLOCK_50;
	output [7:0] VGA_R;
	output [7:0] VGA_G;
	output [7:0] VGA_B;
	output VGA_BLANK_N;
	output VGA_CLK;
	output VGA_HS;
	output VGA_SYNC_N;
	output VGA_VS;
	
	logic [10:0] x, y, x_body, y_body, x_arm, y_arm;
	logic one_second, change_color, clk, reset, color, start_clk, fifteen, thirty, fortyfive, timer, done_time;
	
	DFlipFlop sync (.clk, .reset, .Q(SW[9]), .D(reset));
	
	assign start_clk = SW[8]; // start stop switch
	assign clk = CLOCK_50; 
	assign LEDR[9] = done_time; 
	
	// adding more ways for the user to interact with the program
	assign fifteen = (SW[1] & SW[5]); // to set a 15sec timer 
	assign thirty = (SW[3] & SW[0]); // to set a 30sec timer 
	assign fortyfive = (SW[4] & SW[5]); // to set a 45sec timer
	assign timer = (fifteen | thirty | fortyfive); // to check if there is a timer set

	clock_divider clock (.clk, .reset, .one_second, .change_color); 
	
	always_ff @(posedge clk or posedge reset) begin 
		if(reset) 
			color <= 1; 
		else if (change_color)
			color <= ~color; 
	end 
	
	VGA_framebuffer fb (
		.clk50			(CLOCK_50), 
		.reset			(1'b0), 
		.x, 
		.y,
		.pixel_color	(color), 
		.pixel_write	(1'b1),
		.VGA_R, 
		.VGA_G, 
		.VGA_B, 
		.VGA_CLK, 
		.VGA_HS, 
		.VGA_VS,
		.VGA_BLANK_n	(VGA_BLANK_N), 
		.VGA_SYNC_n		(VGA_SYNC_N));
		
//	assign HEX0 = '1;
//	assign HEX1 = '1;
	assign HEX2 = 7'b1110110;
//	assign HEX3 = '1;
	assign HEX4 = '1;
 	assign HEX5 = '1;
	
	logic clk_done; 
	
	always_ff @(posedge clk) begin 
		if(clk_done) begin 
			x <= x_arm; 
			y <= y_arm;
		end else begin 
			x <= x_body; 
			y <= y_body; 
		end 
	end 
	
	clock_body body (.clk, .reset, .x(x_body), .y(y_body), .clk_done);
	
	clock_arm arm (.clk, .reset, .x(x_arm), .y(y_arm), .one_second, .change_color, .start_clk, .fifteen, .thirty, .fortyfive, .timer);
	
	displays show (.clk, .reset, .H0(HEX0), .H1(HEX1), .H3(HEX3), .one_second, .start_clk, .fifteen, .thirty, .fortyfive, .timer, .done_time); 

endmodule 