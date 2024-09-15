module tb_ALU;

  reg [15:0] A, B;
  reg [2:0] ALUOp;
  reg En;
  wire Z, N;
  wire [15:0] result;
  ALU uut (.A(A),.B(B),.ALUOp(ALUOp),.Z(Z),.N(N),.result(result),.En(En));
  initial begin
    A = 16'h0000;
    B = 16'h0000;
    ALUOp = 4'b0000;
    En = 0;
    $dumpfile("tb_ALU.vcd");
    $dumpvars(0, tb_ALU);
	
    A = 16'h0010;      // Test Case 1: A + B (Addition)
    B = 16'h0020;
    ALUOp = 4'b000;  
    En = 1;
    #10;
	
    A = 16'h0030;	    // Test Case 2: A - B (Subtraction)
    B = 16'h0020;
    ALUOp = 4'b001;  
    #10;

    A = 16'h00FF;	     // Test Case 3: A & B (AND)
    B = 16'h0F0F;
    ALUOp = 4'b010;  
    #10;

    A = 16'h00FF;	      // Test Case 4: A | B (OR)
    B = 16'h0F0F;
    ALUOp = 4'b011;  
    #10;

    A = 16'h00FF;	      // Test Case 5: A ^ B (XOR)
    B = 16'h0F0F;
    ALUOp = 4'b100;  
    #10;

    A = 16'h0000;        // Test Case 6: Check Zero and Negative Flags
    B = 16'h0000;
    ALUOp = 4'b000;      // Add (result should be 0)
    #10;

    A = 16'h8000;
    B = 16'h0000;
    ALUOp = 4'b000;      // Add (result should be negative)
    #10;

    $finish;
  end
endmodule
