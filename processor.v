module processor();	
	wire clk; 
	//Control unit outputs
	wire enIF, enID, enEX, enMEM, enWB; // Stage enables
	wire RegSource, MemRead, MemWrite, RegWrite;  // Control signals
    wire [2:0] ALUOp;  // ALU operation
	
	//Enables
	wire enPC, enInstructionMemory, enRegFile, enALU, enDataMemory;
	
	//Fetch
	wire [15:0] pc;
	
	//Decode
	wire [15:0] instruction;
	// instruction format
	wire [3:0] opCode;
	wire [3:0] Rd, Rs1, Rs2; 
	
	//register file
	wire [3:0] RA, RB, RW; //register file inputs
	wire [15:0] BusA, BusB; //read buses
	wire [15:0] BusW; //write bus
	
	//Excecute
	wire [15:0] A, B; //ALU inputs 
	wire Z, N; //Flags
	wire [15:0] result; //ALU result
	
	//Memory
	wire [15:0] dataIn, memoryAddress; //Memory Address
	wire [15:0] dataOut; //Memory result
	
	//Assignments
	//Fetch Stage
	assign enPC = enIF;
	assign enInstructionMemory = enIF;
	
	//Decode Stage
	//Split the instruction
	assign opCode = instruction[15:12];
	assign Rd = instruction[11:8];
	assign Rs1 = instruction[7:4];
	assign Rs2 = instruction[4:0];
	
	//Regestir File Functionallity
	assign RA = Rs1;
	assign RB = (RegSource == 0) ? Rs2 : Rd;
	//assign RW=Rd;
	assign enRegFile = (enID || enWB);
	
	//Excecution Stage
	assign enALU = enEX;
	assign A = BusA;
	assign B = BusB;
	
	//Memory
	assign enDataMemory = enMEM; 
	assign memoryAddress = BusA;
	assign dataIn = BusB;
	
	clkGenerator clkGeneratorModule(clk);
	controlUnit controlUnitModule(clk, opCode, enIF, enID, enEX, enMEM, enWB, RegSource, MemRead, MemWrite, RegWrite, ALUOp);
	PC PCModule(clk,pc,enPC);
	instructionMemory instructionMemoryModule(clk, pc, instruction, enInstructionMemory);
	registerFile registerFileModule(clk, RA, RB, RW, RegWrite, BusA, BusB, BusW, enRegFile);
	ALU ALUModule(A, B, ALUOp, Z, N, result, enALU);
	dataMemory dataMemoryModule(clk, memoryAddress, dataIn, MemRead, MemWrite, dataOut, enDataMemory);
	assign BusW = (RegWrite==0) ? result : dataOut;
	
endmodule