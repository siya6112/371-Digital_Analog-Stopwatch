module displays_tb(); 
	logic clk, reset, one_second, start_clk, fifteen, thirty, fortyfive, timer, done_time;
	logic [6:0] H0, H1, H3; 
	
	displays dut (.*); 
	
	initial begin 
		clk <= 0; 
		forever #(100/2) clk <= ~clk; 
	end 
	
	initial begin 
		reset <= 1; @(posedge clk); 
		reset <= 0; @(posedge clk); 
		
		for(int i = 0; i <= 60; i++) begin 
			one_second <= 1; fifteen <= 0; thirty <= 0;  fortyfive <= 0; timer <= 0; start_clk <= 1; @(posedge clk); 
			one_second <= 0; start_clk <= 0; @(posedge clk); 
		end 
		
		fifteen <= 1; thirty <= 0;  fortyfive <= 0; timer <= 1; @(posedge clk);
		reset <= 1; @(posedge clk); 
		reset <= 0; @(posedge clk); 
		
		for(int i = 0; i <= 15; i++) begin 
			one_second <= 1; start_clk <= 1; @(posedge clk); 
			one_second <= 0; start_clk <= 0; @(posedge clk); 
		end
		
		$stop;
	end
endmodule 