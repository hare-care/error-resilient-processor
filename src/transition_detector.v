module transition_detector 
    #(parameter DATA_WIDTH = 1) (
        input clk, reset,
        input [DATA_WIDTH-1:0] data,
        output reg [DATA_WIDTH-1:0] transition
    );

    wire [DATA_WIDTH-1:0] and_out;
    wire [DATA_WIDTH-1:0] buf_out;
    wire [DATA_WIDTH-1:0] nor_out;
    wire [DATA_WIDTH-1:0] xor_out;

    assign and_out = data & 1;
    assign buf_out = and_out;
    assign nor_out = ~(buf_out | 1);
    assign xor_out = data ^ nor_out;

    always @(posedge xor_out) begin
        if (reset==1'b1)
            transition <= 1'b0;
        else
            transition <= clk;
    end




endmodule