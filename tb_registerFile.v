module tb_registerFile;
  reg clk, En, EnW;
  reg [3:0] RA, RB, RW;
  reg [15:0] BusW;
  wire [15:0] BusA, BusB;

  // Instantiate the registerFile module
  registerFile uut (.clk(clk),.RA(RA),.RB(RB),.RW(RW),.EnW(EnW),.BusW(BusW),.En(En),.BusA(BusA),.BusB(BusB));
  always #5 clk = ~clk;	  // Clock generatio  
  initial begin
    clk = 0;
    En = 0;
    EnW = 0;
    RA = 4'b0000;
    RB = 4'b0000;
    RW = 4'b0000;
    BusW = 16'h0000;

    $dumpfile("tb_registerFile.vcd");  
    $dumpvars(0, tb_registerFile);
   
    #10;
    // Test Case 1: Write data to a register
    RW = 4'b0010;
    RA = 4'b0010;
    BusW = 16'hA5A5;   // Data to write
    EnW = 1;           // Enable write
    #10;
    En=1;
    EnW = 0;           // Disable write
    #10; 
	EnW= 1;	 
   
	 #20;   
	EnW= 0;
    
    // Test Case 2: Read data from registers
    RA = 4'b0010;      // Read from register 2
    RB = 4'b0011;      // Read from register 3 (which should be 0)
    En = 1;            // Enable read
    #10;
    En = 0;            // Disable read
    #10;
    
    $display("BusA: %h (Expected: A5A5)", BusA);
    $display("BusB: %h (Expected: 0000)", BusB);
    $finish;
  end
endmodule
