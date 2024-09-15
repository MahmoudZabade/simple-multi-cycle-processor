module clkGenerator_tb;

    reg clk;

    // Instantiate the ClockGenerator module
    clkGenerator uut (clk);

    initial begin
        $display("Simulation started at time %0t", $time);
    end

    // Monitor block to display clock changes
    always @(posedge clk) begin
        $display("(%0t) Clock toggled to %b", $time, clk);
    end

    // Stop simulation after some time
    initial #100 $finish;

endmodule