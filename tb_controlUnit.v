module tb_controlUnit;
	
    reg clk;
    reg [3:0] opCode;
    wire enIF, enID, enEX, enMEM, enWB;
    wire RegSource, MemRead, MemWrite, RegWrite;
    wire [2:0] ALUOp;

    controlUnit uut (.clk(clk),
	.opCode(opCode),.enIF(enIF),
	.enID(enID),.enEX(enEX),
	.enMEM(enMEM),.enWB(enWB),
	.RegSource(RegSource),.MemRead(MemRead),
	.MemWrite(MemWrite),
	.RegWrite(RegWrite),
	.ALUOp(ALUOp)
	);

    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10-time unit clock period
    end

    initial begin
        $monitor("Time: %0d | opCode: %b | enIF: %b | enID: %b | enEX: %b | enMEM: %b | enWB: %b | RegSource: %b | MemRead: %b | MemWrite: %b | RegWrite: %b | ALUOp: %b",
                 $time, opCode, enIF, enID, enEX, enMEM, enWB, RegSource, MemRead, MemWrite, RegWrite, ALUOp);

        opCode = 4'b0101;  // Set initial opcode load
        #40;  // Wait for a clock cycle
		opCode = 4'b0000;  // Set initial opcode add
        #40;  // Wait for a clock cycle
		opCode = 4'b0001;  // Set initial opcode sub
        #40;  // Wait for a clock cycle
		opCode = 4'b0010;  // Set initial opcode and
        #40;  // Wait for a clock cycle
		opCode = 4'b0110;  // Set initial opcode store
        #40;  // Wait for a clock cycle
        $finish;
    end
endmodule
