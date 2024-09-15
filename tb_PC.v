module tb_PC;

  // Testbench signals
  reg clk, En;
  wire [15:0] PC;

  // Instantiate the PC module
  PC uut (
    .clk(clk),
    .En(En),
    .PC(PC)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Testbench procedure
  initial begin
    // Initialize signals
    clk = 0;
    En = 0;

    // Set up VCD file generation for waveform
    $dumpfile("tb_PC.vcd");  
    $dumpvars(0, tb_PC);

    // Check initial value of PC
    #5;
    $display("Initial PC value: %d (Expected: 0)", PC);

    // Test Case 1: Enable PC increment
    En = 1;
    #20;  // Wait for 4 clock cycles
    En = 0;
    #10;  // Let the clock run with En = 0
    $display("PC value after 4 increments: %d (Expected: 4)", PC);

    // Test Case 2: Further increment PC
    En = 1;
    #30;  // Wait for 6 more clock cycles
    En = 0;
    #10;  // Let the clock run with En = 0
    $display("PC value after 6 more increments: %d (Expected: 10)", PC);

    // Finish simulation
    $finish;
  end
endmodule
