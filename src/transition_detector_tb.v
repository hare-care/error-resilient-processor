module transition_detector_tb();

wire transition;
reg clk, data, reset;

transition_detector dft(.clk(clk), .reset(reset), .data(data), .transition(transition));

initial begin
    reset = 1;
    clk = 0;
    data = 0;
    #10;
    reset = 0;
    #15 data = 1;
    #5 data = 0;
    #10 data = 1;
    #25 data = 0;
    #5
    $finish;
end

always begin
    clk <= ~clk;
    #5;
end

initial begin
    $dumpfile("TD.vcd");
    $dumpvars(0, transition_detector_tb);
end



endmodule