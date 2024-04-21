/// sta-blackbox
module Top_csr (
    input clk,
    input rst,
    input data_sample,
    output error
);

    wire replica_out;
    csr_replica csr_replica(
        .in(data_sample),
        .out(replica_out)
    );
    error_detector ed(
        .data(replica_out),
        .clk(clk),
        .reset(rst),
        .error(error)
    ); 
endmodule