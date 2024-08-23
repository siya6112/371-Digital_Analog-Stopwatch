module clock_divider (clk, reset, one_second, change_color);
	
	input logic clk, reset; 
	output logic one_second, change_color; 
	
    parameter CLOCK_CYCLES_PER_SECOND = 50000000;

    // Register to keep track of the clock cycles
    logic [26:0] counter;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            one_second <= 0;
				change_color <= 0; 
        end else begin
            if (counter == CLOCK_CYCLES_PER_SECOND - 1) begin
                counter <= 0;
                one_second <= 1; // Generate the pulse
					 change_color <= 1;
            end else if (counter == (CLOCK_CYCLES_PER_SECOND - 1) / 2) begin
                counter <= counter + 1'b1;
                one_second <= 0;
					 change_color <= 1; 
				end else begin
                counter <= counter + 1'b1;
                one_second <= 0;
					 change_color <= 0; 
            end
        end
    end
endmodule
