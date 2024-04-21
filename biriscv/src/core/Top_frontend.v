/// sta-blackbox
module Top_frontend (
    input clk,
    input nrst,
    input data_sample,
    output error
);

    wire replica_out;
    frontend_replica frontend_replica(
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