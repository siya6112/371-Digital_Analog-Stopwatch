/* Given two points on the screen this module draws a line between
 * those two points by coloring necessary pixels
 *
 * Inputs:
 *   clk    - should be connected to a 50 MHz clock
 *   reset  - resets the module and starts over the drawing process
 *   start  - starts the module to color
 *	  x0 	- x coordinate of the first end point
 *   y0 	- y coordinate of the first end point
 *   x1 	- x coordinate of the second end point
 *   y1 	- y coordinate of the second end point
 *
 * Outputs:
 *   x 		- x coordinate of the pixel to color
 *   y 		- y coordinate of the pixel to color
 *   done	- flag that line has finished drawing
 *
 */
module line_drawer(clk, reset, start, x0, y0, x1, y1, x, y, done);
	input logic clk, reset, start;
	input logic [10:0]	x0, y0, x1, y1;
	output logic done;
	output logic [10:0]	x, y;
	
	/* You'll need to create some registers to keep track of things
	 * such as error and direction.
	 */
	
	// Temp variables to setup the drawing 
	logic [10:0] x0_temp1, x1_temp1, y0_temp1, y1_temp1, abs_x, abs_y;
	logic [10:0] x0_temp2, x1_temp2, y0_temp2, y1_temp2, next_x, next_y;
	
	// Logic variables needed 
	logic is_steep;
	logic signed [11:0] error, delta_x, delta_y, y_step; // example - feel free to change/delete
	
	// Calculates the absolute values of x and y
	assign abs_x = (x1 > x0) ? x1 - x0: x0 - x1;
	assign abs_y = (y1 > y0) ? y1 - y0: y0 - y1;
	
	// Find if the line steep or not and if it is done drawing
	assign is_steep = (abs_y > abs_x);
	
	// Calculates the delta values of x and y
	assign delta_x = x1_temp2 - x0_temp2;
	assign delta_y = (y1_temp2 > y0_temp2) ? y1_temp2 - y0_temp2: y0_temp2 - y1_temp2;
	
	// Create states for the machine
	enum {s_start, s_draw, s_done} ps, ns;
	
	
	always_comb begin
		// Logic for the states
		// Stays in s_draw (drawing state) until it reached end destination 
		case(ps)		
			s_start: ns = start ? s_draw : s_start;
			
			s_draw:	if( next_x < x1_temp2) ns = s_draw;
						else ns = s_done;
			
			s_done:	ns =  start ? s_done : s_start;
		endcase
		
		// Logic based on the given psuedocode 
		// If the line is steep then swap x and y
		if( is_steep) 
			begin
				x0_temp1 = y0;
				x1_temp1 = y1;
				y0_temp1 = x0;
				y1_temp1 = x1;
			end 
		else 
			begin
				x0_temp1 = x0;
				x1_temp1 = x1;
				y0_temp1 = y0;
				y1_temp1 = y1;
			end 
		
		// If x0 > x1, then swap (x0,x1) and (y0,y1)
		if (x0_temp1 > x1_temp1) 
			begin
				x0_temp2 = x1_temp1;
				x1_temp2 = x0_temp1;
				y0_temp2 = y1_temp1;
				y1_temp2 = y0_temp1;
			end
		else 
			begin
				x0_temp2 = x0_temp1;
				x1_temp2 = x1_temp1;
				y0_temp2 = y0_temp1;
				y1_temp2 = y1_temp1;
			end
		
		// Setup the y_step based on y
		if (y0_temp2 < y1_temp2)
			y_step = 1;
		else
			y_step = -1;
			
	end // always_comb
	
	always_ff @(posedge clk) begin
		// YOUR CODE HERE
		// Resets the whole fsm 
		if(reset)
			begin
				next_x <= 0;
				next_y <= 0;
				error <= 0;
				ps <= s_start;
			end
		else
				ps <= ns;
				
		// Sets up the data based on the provided pseudocode			
		if (ps == s_start)
			begin
				next_x <= x0_temp2;
				next_y <= y0_temp2;
				error <= -(delta_x/2);
			end 
				
		else if((ps == s_draw))
			begin 
				//Increments the next x-value
				next_x <= next_x + 1;
				
				// Sets x and y of the pixel based on steep
				if(is_steep)
					begin
						x <= next_y;
						y <= next_x;
					end
				else
					begin
						x <= next_x;
						y <= next_y;
					end
				
				// Sets up the error for each draw
				if((error + delta_y) >= 0)
					begin 
						error <= error + delta_y - delta_x;
						next_y <= next_y + y_step;
					end
				else 
					begin
						next_y <= next_y;
						error <= error + delta_y;
					end
			end
	end  // always_ff
	
	// Sets up the 
	assign done = (ps == s_done);
	
endmodule  // line_drawer