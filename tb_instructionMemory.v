module tb_instructionMemory;

  reg clk, En;
  reg [15:0] address;
  wire [15:0] instruction;

  instructionMemory uut (.clk(clk),.En(En),.address(address),.instruction(instruction));  
  
  always #5 clk = ~clk;	   // Clock generation	
	  
  initial begin
    clk = 0;
    En = 0;
    address = 16'h0000;
    $dumpfile("tb_instructionMemory.vcd");  
    $dumpvars(0, tb_instructionMemory);

    uut.memory[0] = 16'h1234;
    uut.memory[1] = 16'hABCD;
    uut.memory[2] = 16'h5678;
    uut.memory[3] = 16'h9ABC;

    En = 1;
    address = 16'h0000;	      // Test Case 1: Enable read and read from address 0
    #10;
    $display("Instruction at address 0x0000: %h (Expected: 1234)", instruction);

    address = 16'h0001;	     // Test Case 2: Read from address 1
    #10;
    $display("Instruction at address 0x0001: %h (Expected: ABCD)", instruction);

    address = 16'h0002;	     // Test Case 3: Read from address 2
    #10;
    $display("Instruction at address 0x0002: %h (Expected: 5678)", instruction);

    address = 16'h0003;		  // Test Case 4: Read from address 3
    #10;
    $display("Instruction at address 0x0003: %h (Expected: 9ABC)", instruction);

    En = 0;
    address = 16'h0001;	     // Test Case 5: Disable reading and attempt to read (instruction should not change)
    #10;
    $display("Instruction at address 0x0001 with En=0: %h (Expected: Previous instruction value, 9ABC)", instruction);
	
    $finish;
  end
endmodule
