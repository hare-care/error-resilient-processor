/// sta-blackbox
module Top_divider (
    input clk,
    input nrst,
    input data_sample,
    output error
);

    wire replica_out;
    divider_replica divider_replica(
        .in(data_sample),
        .out(replica_out)
    );
    error_detector ed(
        .data(replica_out),
        .clk(clk),
        .reset(nrst),
        .error(error)
    ); 
endmodule