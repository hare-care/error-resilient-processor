module error_detector (
    input data, clk,reset,
    output reg error 
    );
    reg q;
    wire initial_error;
    assign initial_error = data ^ q;
    always @(posedge clk) begin
        q <= data;
    end 
    always @(negedge clk or negedge reset) begin
        if(!reset) begin
            error<=1'b0;
        end
        else begin
            error<=initial_error;
        end
    end 
endmodule
