module error_detector_tb();
parameter DATA_WIDTH = 1;
reg [DATA_WIDTH-1:0] d;
reg clk, rst;
wire error,trans,diff;

error_detector #(.DATA_WIDTH(DATA_WIDTH)) uut (
    .d(d),
    .clk(clk),
    .rst(rst),
    .transition(trans),
    .difference(diff),
    .error(error)

);


initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

// Test stimulus
initial begin
    rst = 1; d = 0;
    #1 rst = 0;

    #6 d = 1'b1;
    #25 d = 1'b0;
    #35 d = 1'b1;
    #25 d = 1'b0;

    #20 $finish;
end

// Monitor
initial begin
    $monitor("Time = %d, rst = %b, d = %b, error = %b,transition=%b,difference=%b", $time, rst, d, error,trans,diff);
end
endmodule 
