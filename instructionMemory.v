module instructionMemory(clk, address, instruction, En);
	input clk,En;
	input [15:0] address;
	output reg [15:0] instruction;
	reg [15:0] memory [0:65535]; 
	
	
		initial begin
		// Example instruction initialization 
	// Step 1: Load operands from memory
	memory[0] = 16'b0101_0001_0000_0100; // LOAD R1, [R4]      ; Load data from address in R4 into R1
	memory[1] = 16'b0101_0010_0000_0101; // LOAD R2, [R5]      ; Load data from address in R5 into R2
	memory[2] = 16'b0101_0011_0000_0110; // LOAD R3, [R6]      ; Load data from address in R6 into R3
	
	// Step 2: Perform arithmetic operations
	memory[3] = 16'b0000_0001_0010_0011; // ADD  R1, R2, R3    ; ADD R1, R2, R3
	memory[4] = 16'b0001_0100_0101_0110; // SUB  R4, R5, R6    ; SUB R4, R5, R6
	memory[5] = 16'b0010_0111_1000_0000; // AND  R7, R8, R0    ; AND R7, R8, R0
	memory[6] = 16'b0011_1001_1010_0000; // OR   R9, R10, R0   ; OR  R9, R10, R0
	memory[7] = 16'b0100_1011_1100_0000; // XOR  R11, R12, R0  ; XOR R11, R12, R0
	
	// Step 3: Store results back to memory
	memory[8] = 16'b0110_0001_0000_0100; // STORE R1, [R4]     ; Store result from R1 back to address in R4
	memory[9] = 16'b0110_0100_0000_0101; // STORE R4, [R5]     ; Store result from R4 back to address in R5
	memory[10] = 16'b0110_0111_0000_0110; // STORE R7, [R6]    ; Store result from R7 back to address in R6
	memory[11] = 16'b0110_1001_0000_0111; // STORE R9, [R7]    ; Store result from R9 back to address in R7
	memory[12] = 16'b0110_1011_0000_1000; // STORE R11, [R8]   ; Store result from R11 back to address in R8
	
	// Step 4: Load the stored results to verify
	memory[13] = 16'b0101_0001_0000_0100; // LOAD R1, [R4]      ; Load the updated value from address in R4 back into R1
	memory[14] = 16'b0101_0100_0000_0101; // LOAD R4, [R5]      ; Load the updated value from address in R5 back into R4
	memory[15] = 16'b0101_0111_0000_0110; // LOAD R7, [R6]      ; Load the updated value from address in R6 back into R7
	memory[16] = 16'b0101_1001_0000_0111; // LOAD R9, [R7]      ; Load the updated value from address in R7 back into R9
	memory[17] = 16'b0101_1011_0000_1000; // LOAD R11, [R8]     ; Load the updated value from address in R8 back into R11

	end
	
	
	always @(posedge clk)begin	 
		if(En)begin
		instruction =memory[address];	
		end
	end 			
endmodule		
