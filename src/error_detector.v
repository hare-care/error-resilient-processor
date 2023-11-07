module error_detector (output error, input d, clk);
    reg q;

    always @(posedge clk) begin
        q <= d;
    end 

    assign error = d ^ q;
endmodule
