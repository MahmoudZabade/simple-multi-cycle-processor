module ALU (A, B, ALUOp, Z, N, result, En);
  input [15:0] A, B;
  input [2:0] ALUOp; 
  input En;
  output Z, N;
  output reg [15:0] result;

  assign Z = (result == 0); // Zero flag
  assign N = (result[15] == 1); // Negative flag
  
  always @(*) begin
    if (En) begin
      case (ALUOp)
        3'b000 : result = A + B;
        3'b001 : result = A - B;
        3'b010 : result = A & B;
        3'b011 : result = A | B;
        3'b100 : result = A ^ B;
        default : result = 0;
      endcase
    end else begin
      result = 0;
    end
  end
endmodule
