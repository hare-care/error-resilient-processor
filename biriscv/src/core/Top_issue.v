/// sta-blackbox
module Top_issue (
    input clk,
    input nrst,
    input data_sample,
    output error
);

    wire replica_out;
    issue_replica issue_replica(
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