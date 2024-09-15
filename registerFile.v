module registerFile(clk, RA, RB, RW, EnW, BusA, BusB, BusW, En);
	input clk, En, EnW;
	input [3:0] RA, RB, RW;	
	input [15:0] BusW;
	output reg [15:0]  BusA, BusB;	
	reg [15:0] registerArray [15:0];	 
	
	initial begin
	// Initialize registers with specific values
	registerArray[0]  <= 16'h0001;  // Example: Initialize to 1
	registerArray[1]  <= 16'h0002;  // Example: Initialize to 2
	registerArray[2]  <= 16'h0003;  // Example: Initialize to 3
	registerArray[3]  <= 16'h0004;  // Example: Initialize to 4
	registerArray[4]  <= 16'h0005;  // Example: Initialize to 5
	registerArray[5]  <= 16'h0006;  // Example: Initialize to 6
	registerArray[6]  <= 16'h0007;  // Example: Initialize to 7
	registerArray[7]  <= 16'h0008;  // Example: Initialize to 8
	registerArray[8]  <= 16'h0009;  // Example: Initialize to 9
	registerArray[9]  <= 16'h000A;  // Example: Initialize to 10 (hexadecimal A)
	registerArray[10] <= 16'h000B;  // Example: Initialize to 11 (hexadecimal B)
	registerArray[11] <= 16'h000C;  // Example: Initialize to 12 (hexadecimal C)
	registerArray[12] <= 16'h000D;  // Example: Initialize to 13 (hexadecimal D)
	registerArray[13] <= 16'h000E;  // Example: Initialize to 14 (hexadecimal E)
	registerArray[14] <= 16'h000F;  // Example: Initialize to 15 (hexadecimal F)
	registerArray[15] <= 16'h0010;  // Example: Initialize to 16

	end
	always @(posedge clk)begin	  
		if(En)begin 
			BusA= registerArray[RA];	
			BusB= registerArray[RB];
		end	
	end	  
	
	always @(EnW)begin 
		if(En)begin
		registerArray[RW] = BusW;
		end
	end 
	
	

endmodule
	
