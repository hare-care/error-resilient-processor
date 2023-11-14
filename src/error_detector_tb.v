module error_detector_tb;
    reg data;
    reg clk;
    wire error;

error_detector ED (.error(error), .data(data), .clk(clk));

initial begin
    clk = 0;
    data = 0;
    #70
    $finish;
end

always begin
    #5 clk = ~clk;
end

always begin
    #7 data = ~data;
end

initial begin
   $dumpfile("ED.vcd");
   $dumpvars(0, error_detector_tb);
 end

endmodule
