/// sta-blackbox
module Top_exec (
    input clk,
    input nrst,
    input data_sample,
    output error
);

    wire replica_out;
    exec_replica exec_replica(
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