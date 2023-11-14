module error_detector (output error, input data, clk);
    reg q;

    always @(posedge clk) begin
        q <= data;
    end 

    assign error = data ^ q;
endmodule
