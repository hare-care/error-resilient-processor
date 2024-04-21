module final_error_detector
    # (parameter DATA_WIDTH = 1) (
        input clk, reset,
        input [DATA_WIDTH-1:0] data,
        output error
    );


    wire transition, initial_error;

    transition_detector TD(.clk(clk), .reset(reset), .data(data), .transition(transition));
    error_detector ED(.error(initial_error), .data(data), .clk(clk));

    assign error = initial_error & transition;
endmodule

