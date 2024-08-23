/* Given center point and a radius on the screen this module draws a circle 
 * based on the radius around the center point. 
 *
 * Inputs:
 *   clk    - representing the clock 
 *   reset  - resets the module and start new doing the circle 
 *	  x1 	- x coordinate of the center point
 *   y1 	- y coordinate of the center point
 *   r 	- radius of the circle 
 *  
 * Outputs:
 *   x 		- x coordinate of the pixel to draw
 *   y 		- y coordinate of the pixel to draw
 *	  point  - indicate when a new point is given to line 
 *   done	- indicates when it was finished drawing the circle
 *
 */
module circle_drawer(clk, reset, x1, y1, r, x, y, point, done); 

	input logic clk, reset; 
	input logic [10:0] x1, y1, r; 
	output logic [10:0] x, y;
	output logic point;
	output logic done; 
	
	// Temp variables to setup the circle 
	logic signed [11:0] xa, ya; 
	logic signed [13:0] err, err_temp; 
	logic [1:0] quad; 
	
	// Create the states for the machine 
	enum {s_idle, s_y, s_x, s_draw, s_done} ps, ns; 
	
	always_comb begin 
		// Indicate the next state logic 
		case(ps)
			s_idle: ns = s_y; 
			s_y: ns = s_x; 
			s_x: ns = s_draw; 
			s_draw:
				if(xa == 0) 
					ns = s_done; 
				else 
					ns = s_y;
			s_done: ns = s_done; 
		endcase
	end //always_comb
	
	always_ff @(posedge clk) begin 
		// Resets the whole fsm
		if(reset) 
			ps <= s_idle; 
		else 
			ps <= ns; 
			
		// Sets up the point based on the Bresenham's circle algorithm
		if (ps == s_idle) begin 
			done <= 0; 
			xa <= -r; 
			ya <= 0; 
			err <= 2 - (2 * r); 
			quad <= 2'b00; 
		// Calculate the next y cord and error
		end else if (ps == s_y) begin 
			err_temp <= err; 
			if(err <= ya) begin 
				ya <= ya + 1; 
				err <= err + 2 * (ya + 1) + 1; 
			end else begin 
				ya <= ya; 
				err <= err; 
			end 
		// Calculate the next x cord and error 
		end else if (ps == s_x) begin 
			if(err_temp > xa | err > ya) begin 
				xa <= xa + 1; 
				err <= err + 2 * (xa + 1) + 1; 
			end else begin 
				xa <= xa; 
				err <= err; 
			end 
		// Create the new coordinates to draw and give to the line algorithm
		end else if (ps == s_draw) begin 
			case (quad)
				2'b00: begin
					x <= x1 - xa; 
					y <= y1 + ya; 
				end 
				2'b01: begin 
					x <= x1 - ya; 
					y <= y1 - xa;
				end 
				2'b10: begin 
					x <= x1 + xa; 
					y <= y1 - ya; 
				end 
				2'b11: begin 
					x <= x1 + ya; 
					y <= y1 + xa; 
				end 
			endcase 
			
			quad <= quad + 1'b1; 
		end else if (ps == s_done)
			done <= 1; 
	end // always_ff 
	
	// Indicate when a point is created
	assign point = (ps == s_draw);

endmodule 