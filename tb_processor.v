module tb_processor;

    // Instantiate the processor module
    processor uut();

    // Clock generation
    initial begin
        uut.clkGeneratorModule.clk = 0;
        forever #5 uut.clkGeneratorModule.clk = ~uut.clkGeneratorModule.clk; // Clock with a 10 time-unit period
    end

    // Test sequence
    initial begin
        // Initialize instruction memory and registers
        // Preload specific instructions to test the processor's functionality
        // Example instructions:
        uut.instructionMemoryModule.memory[0] = 16'h0123;  // Example instruction 1
        uut.instructionMemoryModule.memory[1] = 16'hA234;  // Example instruction 2
        uut.instructionMemoryModule.memory[2] = 16'h5678;  // Example instruction 3
        
        // Preload register file with values
        uut.registerFileModule.registerArray[0] = 16'h0001;  // Preload register 0 with 0x0001
        uut.registerFileModule.registerArray[1] = 16'h0002;  // Preload register 1 with 0x0002
        uut.registerFileModule.registerArray[2] = 16'h0003;  // Preload register 2 with 0x0003
        uut.registerFileModule.registerArray[3] = 16'h0004;  // Preload register 3 with 0x0004

        // Monitor the key signals to observe the processor's behavior
        $monitor("Time: %0d | PC: %h | Instruction: %h | BusA: %h | BusB: %h | ALU Result: %h | DataOut: %h",
                 $time, uut.pc, uut.instruction, uut.BusA, uut.BusB, uut.result, uut.dataOut);

        // Run the simulation for 1000 time units
        #1000;  

        // Finish the simulation
        $finish;
    end

endmodule
