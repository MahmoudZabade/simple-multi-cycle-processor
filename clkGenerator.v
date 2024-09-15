module clkGenerator (clk);

	initial begin
	    $display("(%0t) > initializing clock generator ...", $time);
	end
	
	output reg clk=0; // starting LOW is important for first instruction fetch
	
	always #5 begin
	    clk = ~clk;
	end			   

endmodule
