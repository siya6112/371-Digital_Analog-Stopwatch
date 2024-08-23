module clock_arm(clk, reset, x, y, one_second, change_color, start_clk, fifteen, thirty, fortyfive, timer);
	input logic clk, reset, one_second, change_color, start_clk, fifteen, thirty, fortyfive, timer; 
	output logic [10:0] x, y; 
	
	logic [8:0] x_f, y_f;
	logic [10:0] x_t, y_t, centrex, centrey; 
	logic done, start;
	logic [5:0] counter;
	
	always_ff @(posedge clk) begin 
		if(reset | (counter == 6'd60)) begin 
			if(~timer)
				counter <= 6'd0; 
			else if(timer) begin 
				if(fifteen)
					counter <= 6'd15; 
				else if (thirty)
					counter <= 6'd30; 
				else if(fortyfive)
					counter <= 6'd45; 
			end 
		end else if (start_clk) begin   
			if(one_second & done) begin
				if(timer & (counter == 6'd0))
					counter <= counter; 
				else if(timer) 
					counter <= counter - 1'b1; 
				else 
					counter <= counter + 1'b1; 
			end else begin 
				counter <= counter; 
			end
		end else 
			counter <= counter; 
		
		if(reset)
		    start <= 1; 
		else if ((one_second | change_color) & done) 
		    start <= 0; 
		else 
		    start <= 1; 
	end
	
    assign x_t = (reset | (counter == 6'd0)) ? 10'd320 : {2'b00, x_f}; 
    assign y_t = (reset | (counter == 6'd0)) ? 10'd140 : {2'b00, y_f};  
	
	RAM_arm_x x_vals (.address(counter), .clock(clk), .data(0), .wren(1'b0), .q(x_f));
	RAM_arm_y y_vals (.address(counter), .clock(clk), .data(0), .wren(1'b0), .q(y_f));
	
	assign centrex = 11'd320;
	assign centrey = 11'd250; 
	
	line_drawer arm (.clk, .reset, .start, .x0(centrex), .y0(centrey), .x1(x_t), .y1(y_t), .x, .y, .done);
endmodule 