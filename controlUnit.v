module controlUnit(clk, opCode, enIF, enID, enEX, enMEM, enWB, RegSource, MemRead, MemWrite, RegWrite, ALUOp);
	input clk;
    input [3:0] opCode;  // Instruction opcode
    output reg enIF, enID, enEX, enMEM, enWB; // Stage enables
    output reg RegSource, MemRead, MemWrite, RegWrite;  // Control signals
    output reg [2:0] ALUOp;  // ALU operation

    // Define the stages
	parameter INIT = 3'b000;
    parameter FETCH = 3'b001;
    parameter DECODE = 3'b010;
    parameter EXECUTE = 3'b011;
    parameter MEMORY = 3'b100;
    parameter WRITEBACK = 3'b101;

    reg [2:0] currentStage = INIT;
    reg [2:0] nextStage = FETCH;

    always @(posedge clk) begin
        currentStage <= nextStage;
    end

    always @(*) begin
        // Default control signals
        enIF = 0;
        enID = 0;
        enEX = 0;
        enMEM = 0;
        enWB = 0;
		RegSource = 0;
        MemRead = 0;
        MemWrite = 0;
        RegWrite = 0;
        ALUOp = 3'b000;			   	

        case (currentStage)
		   INIT: begin
                enIF = 0;  // Disable instruction fetch
                nextStage = FETCH;
            end
            FETCH: begin
                enIF = 1;  // Enable instruction fetch
                nextStage = DECODE;
            end

            DECODE: begin
                enID = 1;  // Enable instruction decode (register read)
              if (opCode == 4'b0101 || opCode == 4'b0110) begin  // Memory access instructions
					RegSource = 1;
                    nextStage = MEMORY;
              end
                else begin
					RegSource = 0;	    
                    nextStage = EXECUTE;
                end
            end

            EXECUTE: begin
                enEX = 1;  // Enable ALU
                ALUOp = opCode[2:0];  // Set ALU operation
                nextStage = WRITEBACK;
            end

            MEMORY: begin
                enMEM = 1;  // Enable memory access
                if (opCode == 4'b0101) // Load
                  begin
                    MemRead = 1;
                    nextStage = WRITEBACK;
                  end

                else if (opCode == 4'b0110)  // Store
                  begin
                    MemWrite = 1;
                	nextStage = FETCH;
                  end
            end

            WRITEBACK: begin  
                enWB = 1;  // Enable write-back to register file
                if(opCode >=4'b0000 && opCode<= 4'b0100)  
				RegWrite=0;
				else 
				RegWrite=1;
                nextStage = FETCH;
            end
        endcase
    end
endmodule
