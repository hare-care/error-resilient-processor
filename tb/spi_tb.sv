`timescale 1ns / 1ns
module spi_tb();

localparam string INSTR_IN  = "./tb/instructions.txt";
localparam string MEM_IN = "./tb/tcm.bin";

localparam CLOCK_PERIOD = 20;
localparam SPI_CLOCK_PERIOD = 100;

logic clock = 1'b1;
logic sclk = 1'b0;
logic reset = 1'b1;
logic start = 1'b0;
logic done = 1'b0;
logic sclk_flag = 1'b0;

logic        in_full;
logic        in_wr_en  = '0;
logic [23:0] in_din    = '0;
logic        out_rd_en;
logic        out_empty;
logic  [7:0] out_dout;

logic [71:0] data_in;

logic   hold_clock    = '0;
logic   in_write_done = '0;
logic   out_read_done = '0;
integer out_errors    = '0;

logic mosi, miso, p_start;
logic cs = 1'b1;

reg [7:0] mem[255:0];//131072
integer j;
integer f;

logic          mem_i_rd_w = 1'b0; //core
logic          mem_i_flush_w = 1'b0; //core
logic          mem_i_invalidate_w = 1'b0; //core
logic [ 31:0]  mem_i_pc_w = 32'H80000000; // core
logic [ 31:0]  mem_d_addr_w; // both
logic [ 31:0]  mem_d_data_wr_w; // both
logic          mem_d_rd_w; // both
logic [  3:0]  mem_d_wr_w; // both
logic          mem_d_cacheable_w = 1'b0; //core
logic [ 10:0]  mem_d_req_tag_w = '0; //core
logic          mem_d_invalidate_w = 1'b0; //core
logic          mem_d_writeback_w = 1'b0; //core
logic          mem_d_flush_w = 1'b0; //core

// mem control from spi
logic [31:0] data_adr_o_spi, data_wr_o_spi;
logic mem_d_rd_o_spi;
logic [3:0] data_wr_en_o_spi;

logic spi_used = 1'b1;

always_comb begin
    if (spi_used) begin
        mem_d_addr_w = data_adr_o_spi;
        mem_d_data_wr_w = data_wr_o_spi;
        mem_d_rd_w = mem_d_rd_o_spi;
        mem_d_wr_w = data_wr_en_o_spi;
    end else begin
        mem_d_addr_w = 32'H10;
        mem_d_data_wr_w = '0;
        mem_d_rd_w = '0;
        mem_d_wr_w = '0;
    end

end

logic          mem_i_accept_w;
logic          mem_i_valid_w;
logic          mem_i_error_w;
logic [ 63:0]  mem_i_inst_w;
logic [ 31:0]  mem_d_data_rd_w;
logic          mem_d_accept_w;
logic          mem_d_ack_w;
logic          mem_d_error_w;
logic [ 10:0]  mem_d_resp_tag_w;

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

// assign cs = ~sclk_flag;


slave_spi DUT(
    .sclk(sclk),
    .clk(clock),
    .cs(cs),
    .mosi(mosi),
    .rstn(reset),
    .miso(miso),
    .start_flag(p_start),
    .data_rd_i(mem_d_data_rd_w),
    .data_rd_en_o(mem_d_rd_o_spi),
    .data_adr_o(data_adr_o_spi),
    .data_wr_o(data_wr_o_spi),
    .data_wr_en_o(data_wr_en_o_spi),
    .mem_ack(mem_d_ack_w),
    .mem_accept(mem_d_accept_w)
);

/* REMEMBER TCM IS ACTIVE HIGH RESET */
tcm_mem
u_mem
(
    // Inputs
     .clk_i(clock)
    ,.rst_i(~reset)
    ,.mem_i_rd_i(mem_i_rd_w)
    ,.mem_i_flush_i(mem_i_flush_w)
    ,.mem_i_invalidate_i(mem_i_invalidate_w)
    ,.mem_i_pc_i(mem_i_pc_w)
    ,.mem_d_addr_i(mem_d_addr_w)
    ,.mem_d_data_wr_i(mem_d_data_wr_w)
    ,.mem_d_rd_i(mem_d_rd_w)
    ,.mem_d_wr_i(mem_d_wr_w)
    ,.mem_d_cacheable_i(mem_d_cacheable_w)
    ,.mem_d_req_tag_i(mem_d_req_tag_w)
    ,.mem_d_invalidate_i(mem_d_invalidate_w)
    ,.mem_d_writeback_i(mem_d_writeback_w)
    ,.mem_d_flush_i(mem_d_flush_w)

    // Outputs
    ,.mem_i_accept_o(mem_i_accept_w)
    ,.mem_i_valid_o(mem_i_valid_w)
    ,.mem_i_error_o(mem_i_error_w)
    ,.mem_i_inst_o(mem_i_inst_w)
    ,.mem_d_data_rd_o(mem_d_data_rd_w)
    ,.mem_d_accept_o(mem_d_accept_w)
    ,.mem_d_ack_o(mem_d_ack_w)
    ,.mem_d_error_o(mem_d_error_w)
    ,.mem_d_resp_tag_o(mem_d_resp_tag_w)
);



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

logic mem_done = 1'b0;


initial begin : mem_in_process
    wait(start);
    for (j=0;j<256;j=j+1) // 131072
        mem[j] = 0;

    f = $fopen(MEM_IN, "r");
    j = $fread(mem, f);
    for (j=0;j<256;j=j+1)  //131072
        u_mem.write(j, mem[j]);
    mem_done = 1'b1;
    $fclose(f);
end


initial begin: data_in_test
    mosi = 1'b0;
    wait(mem_done);
    cs = 1'b0;
    sclk_flag = 1'b1;
    wait(!sclk_flag);
    @(posedge clock);
    @(posedge clock);
    @(posedge clock);
    @(posedge clock);
    @(posedge clock);
    @(posedge clock);
    cs = 1'b0;
    sclk_flag = 1'b1;
    #50500
    done = 1'b1;

end

initial begin: mosi_data_in
    int fd;
    int i = 0;
    int cnt = 0;
    fd = $fopen(INSTR_IN, "r");
    wait(sclk_flag);
    $fscanf(fd, "%h", data_in);
    while (!done) begin
        @(posedge sclk);
        mosi = data_in[i];
        i = i+1;
        if (i > 72) begin
            cnt += 1;
            if (cnt < 2) begin
            sclk_flag = 0;
            end else begin
                sclk_flag = 1'b1;
            end
            cs = 1'b1;
            i = 0;
            $fscanf(fd, "%h", data_in);
            mosi = data_in[i];
        end
    end
    $fclose(fd);
end

initial begin: miso_data_out
    logic [71:0] miso_data_out = '0;
    wait(sclk_flag);
    while (!done) begin 
        @(posedge sclk);
        miso_data_out[71:1] = miso_data_out[70:0];
        miso_data_out[0] = miso;
        if (miso_data_out == 72'h0F000000101140006F) begin
            done = 1'b1;
        end
    end
end



/*
initial begin: sclk_testing
    wait(start);
    sclk_flag = 1'b1;
    #500
    sclk_flag = 1'b0;
    #500
    done = 1'b1;
end
*/





endmodule
