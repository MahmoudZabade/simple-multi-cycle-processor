module tb_dataMemory;

  reg clk, MemR, MemW, En;
  reg [15:0] address, dataIn;
  wire [15:0] dataOut;

  dataMemory uut (.clk(clk),.address(address),.dataIn(dataIn),.MemR(MemR),.MemW(MemW),.dataOut(dataOut),.En(En));

  always #5 clk = ~clk;	  // Clock generation
  initial begin
    clk = 0;
    En = 0;
    MemR = 0;
    MemW = 0;
    address = 16'h0000;
    dataIn = 16'h0000;
    $dumpfile("tb_dataMemory.vcd");  
    $dumpvars(0, tb_dataMemory);

    En = 1;

    // Test Case 1: Write data to memory
    MemW = 1;              // Enable write
    address = 16'h0001;     // Write to address 0x0001
    dataIn = 16'hA5A5;      // Data to write
    #10;
    MemW = 0;               // Disable write

    // Test Case 2: Read data from memory
    #10;
    MemR = 1;               // Enable read
    address = 16'h0001;     // Read from address 0x0001
    #10;
    MemR = 0;               // Disable read
	
    // Test Case 3: Write data to another address
    MemW = 1;              // Enable write
    address = 16'h0002;     // Write to address 0x0002
    dataIn = 16'h5A5A;      // Data to write
    #10;
    MemW = 0;               // Disable write
    En = 0;                 // Disable memory access

    // Test Case 4: Read data from the new address
    #10;
    En = 1;                 // Re-enable memory access
    MemR = 1;               // Enable read
    address = 16'h0002;     // Read from address 0x0002
    #10;
    MemR = 0;               // Disable read

    $finish;
  end
endmodule
