module PC(clk,PC,En);
	input clk, En;
	output reg [15:0] PC;
	
	
	initial begin  
		PC = 16'd0;
	end 
	
	
	always @(posedge clk)begin
		if(En)begin		
			PC <= PC+1;
		end 
		
	end
	endmodule 