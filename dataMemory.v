module dataMemory(clk, address, dataIn, MemR, MemW, dataOut, En);
	input clk, MemR, MemW,En;
	input [15:0] address, dataIn;
	output reg [15:0]dataOut;		
	reg [15:0] memory [0:65535]; 
	
	
	initial begin
        memory[0] = 16'h000A; // Example data at address 0x0000
        memory[1] = 16'h0014; // Example data at address 0x0001
        memory[2] = 16'h0028; // Example data at address 0x0002
        memory[3] = 16'h003C; // Example data at address 0x0003
	    memory[9] = 16'h0044;// Example data at address 0x0009
    end
	
	always @(posedge clk)begin
		if (En)begin   
			if(MemR) begin	
				dataOut= memory[address];
			end 	
		else if(MemW)begin 
			memory[address]=dataIn;
			end 
		end
	end 
endmodule 

	