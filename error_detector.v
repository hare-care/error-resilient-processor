module transition #(
    parameter DATA_WIDTH=3
) (
    input [DATA_WIDTH-1:0]d,
    input clk,rst,
    output reg tran_flag
    //output reg xor_output
);
    wire [DATA_WIDTH-1:0]d1;
    wire [DATA_WIDTH-1:0]d2;
    //wire [DATA_WIDTH-1:0]d3;
    //wire [DATA_WIDTH-1:0]d4;
    wire [DATA_WIDTH-1:0]xor_out;

    assign #0.5 d1=~d; 
    assign #0.5 d2=~d1;
    //assign #0.5 d3=~d2;
    //assign #0.5 d4=~d3;    // gate delay simulation,can be adjusted as required by clk cycle
    assign xor_out=d^ d2;
    always@( xor_out > 0 or rst) begin
        if (rst==1'b1) 
            tran_flag<=1'b0;
        else 
            tran_flag<=clk;    
    end   
endmodule

module difference #(
    parameter DATA_WIDTH=3
) (
    input [DATA_WIDTH-1:0]d,
    input clk,rst,
    output diff_flag


    );
    reg [DATA_WIDTH-1:0] Q;

    always@(posedge clk or rst) begin
        if (rst==1'b1)
            Q<=0;
        else 
            Q<=d;
    end
    assign diff_flag=(Q==d) ? 1'b0:1'b1;
    /*
    always@(Q or d) begin
        if (Q==d) 
            diff_flag<=1'b0;
        else
            diff_flag<=1'b1;
    end
    */
    //assign diff=Q^d;  number of bits is not the same
endmodule

module error_detector #(
    parameter DATA_WIDTH=3
) (
    input [DATA_WIDTH-1:0]d,
    input clk,rst,
    output transition,
    output difference,
    output error
);
    wire trans;
    wire diff;

    transition #(.DATA_WIDTH(DATA_WIDTH)) 
    trans_module(.d(d),.clk(clk),.rst(rst),.tran_flag(trans));
    difference #(.DATA_WIDTH(DATA_WIDTH))
    diff_module(.d(d),.clk(clk),.rst(rst),.diff_flag(diff));

    assign transition=trans;
    assign difference=diff;
    assign error=diff&trans;
    
endmodule