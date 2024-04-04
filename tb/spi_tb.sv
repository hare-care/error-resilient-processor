`timescale 1ns / 1ns
module spi_tb();

localparam CLOCK_PERIOD = 10;
localparam SPI_CLOCK_PERIOD = 50;

logic clock = 1'b1;
logic sclk = 1'b0;
logic reset = 1'b1;
logic start = 1'b0;
logic done;
logic sclk_flag = 1'b0;

logic        in_full;
logic        in_wr_en  = '0;
logic [23:0] in_din    = '0;
logic        out_rd_en;
logic        out_empty;
logic  [7:0] out_dout;

logic   hold_clock    = '0;
logic   in_write_done = '0;
logic   out_read_done = '0;
integer out_errors    = '0;

always begin 
    clock <= 1'b1;
    #(CLOCK_PERIOD/2);
    clock <= 1'b0;
    #(CLOCK_PERIOD/2);
end

always begin
    wait(sclk_flag);
    if (sclk_flag) begin
        sclk <= 1'b1;
        #(SPI_CLOCK_PERIOD/2);
        sclk <= 1'b0;
        #(SPI_CLOCK_PERIOD/2);
    end
end

logic cs, mosi, miso;

slave_spi DUT(
    .sclk(sclk),
    .cs(cs),
    .mosi(mosi),
    .rstn(reset),
    .miso(miso)
);



// run sclk when the flag is up, flag up when data being transferred
// always @(*) begin
//     if (sclk_flag) begin
//     sclk <= 1'b1;
//     #(SPI_CLOCK_PERIOD/2);
//     sclk <= 1'b0;
//     #(SPI_CLOCK_PERIOD/2);
//     end
// end


// regular clock
initial begin
    @(posedge clock);
    reset = 1'b0;
    @(posedge clock);
    reset = 1'b1;
end

initial begin : tb_process
    longint unsigned start_time, end_time;

    @(posedge reset);
    @(posedge clock);
    start_time = $time;

    // start
    $display("@ %0t: Beginning simulation...", start_time);
    start = 1'b1;
    @(posedge clock);
    start = 1'b0;

    wait(done);
    end_time = $time;

    // report metrics
    $display("@ %0t: Simulation completed.", end_time);
    $display("Total simulation cycle count: %0d", (end_time-start_time)/CLOCK_PERIOD);
    $display("Total error count: %0d", out_errors);

    // end the simulation
    $finish;
end

initial begin: sclk_testing
    wait(start);
    sclk_flag = 1'b1;
    #1000
    done = 1'b1;
end





endmodule