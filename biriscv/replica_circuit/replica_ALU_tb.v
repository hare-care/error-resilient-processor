`timescale 1ns / 1ps

module replica_ALU_tb;

    // Inputs
    reg a;

    // Outputs
    wire y;

    // Instantiate the Unit Under Test (UUT)
    replica_ALU uut (
        .A(a), 
        .Y(y)
    );

    // Test procedure
    initial begin
        // Initialize Inputs
        $dumpfile("waveform.vcd");
        $dumpvars(0, replica_ALU_tb);
        $monitor($time,a,y);
        a = 0;

        // Wait 100 ns for global reset to finish
        #100;
        
        // Stimulate the input and observe the output
        a = 1; 
        #10; // wait for 10 ns
        a = 0;
        #10; // wait for 10 ns

        // Add more test cases as needed

        // Finish the simulation
        $finish;
    end
      
endmodule
