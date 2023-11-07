`timescale 1ns/100ps

module error_detector_tb;
    reg d;
    reg clk;
    wire error;

error_detector ED (.error(error), .d(d), .clk(clk));

initial begin
    clk = 0;
    d = 0;
end

always begin
    #5 clk = ~clk;
end

always begin
    #7 d = ~d;
end

initial begin
   $dumpfile("ED.vcd");
   $dumpvars(0, error_detector_tb);
 end

endmodule