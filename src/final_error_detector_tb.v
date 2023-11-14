module final_error_detector_tb;
    reg data;
    reg clk;
    reg reset;
    wire error;
    wire transition;

final_error_detector final_ED (.clk(clk), .reset(reset), .data(data), .error(error));

initial begin
    clk = 1;
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
   $dumpfile("final_ED.vcd");
   $dumpvars(0, final_error_detector_tb);
 end

endmodule



