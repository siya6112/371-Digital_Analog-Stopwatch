module displays(clk, reset, H0, H1, H3, one_second, start_clk, fifteen, thirty, fortyfive, timer, done_time);	
	
	input logic clk, reset, one_second, start_clk, fifteen, thirty, fortyfive, timer; 
	output logic [6:0] H0, H1, H3; 
	output logic done_time; 
	
	logic [3:0] minutes, tens; 
	
	enum {h0, h1, h2, h3, h4, h5, h6, h7, h8, h9} ps, ns; 
	
	always_comb begin 
		case(ps)
			h0: ns = timer ? h9 : h1;  
			h1: ns = timer ? h0 : h2; 
			h2: ns = timer ? h1 : h3; 
			h3: ns = timer ? h2 : h4; 
			h4: ns = timer ? h3 : h5; 
			h5: ns = timer ? h4 : h6; 
			h6: ns = timer ? h5 : h7; 
			h7: ns = timer ? h6 : h8; 
			h8: ns = timer ? h7 : h9; 
			h9: ns = timer ? h8 : h0; 
		endcase
	end 
	
	always_ff @(posedge clk) begin 
		if(reset) begin 
			done_time <= 0;
		   if(~timer) begin
    			ps <= h0; 	
    			tens <= 0; 
    		end else if(timer) begin
    			if(fifteen) begin 
    				tens <= 4'd1; 
    				ps <= h5;
    			end else if(thirty) begin
    				tens <= 4'd3; 
    				ps <= h0;
    			end else if(fortyfive) begin 
    				tens <= 4'd4; 
    				ps <= h5;
    			end 
    		end else begin
				minutes <= 0; 	
				tens <= 0;
			end
		end else if(timer) begin
			if (one_second & start_clk) begin
			    minutes <= 0;
    			if((ps == h0) & (tens != 0)) begin
    				ps <= ns; 
    				tens <= tens - 1'b1;
    			end else if((ps == h0) & (tens == 0)) begin 
    			    ps <= ps;
					 done_time <= 1; 
    			end else 
    				ps <= ns;
			end
		end else if (~timer) begin
			if (one_second & start_clk) begin 
				ps <= ns;
				if((ps == h9) && (tens == 4'd5)) begin
					minutes <= minutes + 4'd1; 
					tens <= 0; 
				end else if (ps == h9) begin 
					minutes <= minutes; 
					tens <= tens + 4'd1; 
				end else begin 
					minutes <= minutes; 
					tens <= tens; 
				end
			end
		end else begin 
			ps <= ps;
			minutes <= minutes; 
			tens <= tens; 
		end
		
		if(ps == h0)
			H0 <= 7'b1000000; 
		else if (ps == h1)
			H0 <= 7'b1111001; 
		else if (ps == h2)
			H0 <= 7'b0100100;
		else if (ps == h3)
			H0 <= 7'b0110000;
		else if (ps == h4)
			H0 <= 7'b0011001;
		else if (ps == h5)
			H0 <= 7'b0010010;
		else if (ps == h6)
			H0 <= 7'b0000010;
		else if (ps == h7)
			H0 <= 7'b1111000;
		else if (ps == h8)
			H0 <= 7'b0000000;
		else if (ps == h9)
			H0 <= 7'b0010000;
	end

	seg7 hex1 (.hex(tens), .leds(H1));
	seg7 hex3 (.hex(minutes), .leds(H3));

endmodule 