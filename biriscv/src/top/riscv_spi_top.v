module riscv_new_top(
    `ifdef USE_POWER_PINS
        inout vccd1,
        inout vssd1,
    `endif
    input clk, spi_clk, spi_cs, spi_mosi,
    input rst,
    output spi_miso,
    output error_flag,
    output [63:0]instruction,
    output [31:0]data_write,
    output [31:0]data_read,
    output [31:0]pc
    );
wire          mem_i_rd_w;
wire          mem_i_flush_w;
wire          mem_i_invalidate_w;
wire [ 31:0]  mem_i_pc_w;
wire [ 31:0]  mem_d_addr_w;
wire [ 31:0]  mem_d_data_wr_w;
wire          mem_d_rd_w;
wire [  3:0]  mem_d_wr_w;
wire          mem_d_cacheable_w;
wire [ 10:0]  mem_d_req_tag_w;
wire          mem_d_invalidate_w;
wire          mem_d_writeback_w;
wire          mem_d_flush_w;
wire          mem_i_accept_w;
wire          mem_i_valid_w;
wire          mem_i_error_w;
wire [ 63:0]  mem_i_inst_w;
wire [ 31:0]  mem_d_data_rd_w;
wire          mem_d_accept_w;
wire          mem_d_ack_w;
wire          mem_d_error_w;
wire [ 10:0]  mem_d_resp_tag_w;
wire timing_error;
assign instruction=mem_i_inst_w;
assign pc=mem_i_pc_w;
assign data_write=mem_d_data_wr_w;
assign data_read=mem_d_data_rd_w;

wire p_start_flag, data_rd_en_o_spi;
wire [31:0] data_adr_o_spi, data_wr_o_spi;
wire [3:0] data_wr_en_o_spi;

assign error_flag = timing_error;

// logic to keep cpu off
wire rst_cpu;
assign rst_cpu = rst | !p_start_flag;

// logic to give spi priority for mem access
// if spi rd or wr are on, then use the spi signals otherwise use the cpu signals
wire [31:0] mem_d_addr_w_mux, mem_d_data_wr_w_mux;
wire mem_d_rd_w_mux;
wire [3:0] mem_d_wr_w_mux;

assign mem_d_addr_w_mux = ((data_rd_en_o_spi | data_wr_en_o_spi[0]))? data_adr_o_spi : mem_d_addr_w;
assign mem_d_data_wr_w_mux = ((data_rd_en_o_spi | data_wr_en_o_spi[0]))? data_wr_o_spi : mem_d_data_wr_w;
assign mem_d_rd_w_mux = data_rd_en_o_spi | mem_d_rd_w;
assign mem_d_wr_w_mux = data_wr_en_o_spi | mem_d_wr_w;


riscv_core
u_dut
//-----------------------------------------------------------------
// Ports
//-----------------------------------------------------------------
(
    `ifdef USE_POWER_PINS
	    .vccd1(vccd1),	// User area 1 1.8V power
	    .vssd1(vssd1),	// User area 1 digital ground
    `endif
    // Inputs
     .clk_i(clk)
    ,.rst_i(rst_cpu)
    ,.mem_d_data_rd_i(mem_d_data_rd_w)
    ,.mem_d_accept_i(mem_d_accept_w)
    ,.mem_d_ack_i(mem_d_ack_w)
    ,.mem_d_error_i(mem_d_error_w)
    ,.mem_d_resp_tag_i(mem_d_resp_tag_w)
    ,.mem_i_accept_i(mem_i_accept_w)
    ,.mem_i_valid_i(mem_i_valid_w)
    ,.mem_i_error_i(mem_i_error_w)
    ,.mem_i_inst_i(mem_i_inst_w)
    ,.intr_i(1'b0)
    ,.reset_vector_i(32'h80000000)
    ,.cpu_id_i('b0)

    // Outputs
    ,.mem_d_addr_o(mem_d_addr_w)
    ,.mem_d_data_wr_o(mem_d_data_wr_w)
    ,.mem_d_rd_o(mem_d_rd_w)
    ,.mem_d_wr_o(mem_d_wr_w)
    ,.mem_d_cacheable_o(mem_d_cacheable_w)
    ,.mem_d_req_tag_o(mem_d_req_tag_w)
    ,.mem_d_invalidate_o(mem_d_invalidate_w)
    ,.mem_d_writeback_o(mem_d_writeback_w)
    ,.mem_d_flush_o(mem_d_flush_w)
    ,.mem_i_rd_o(mem_i_rd_w)
    ,.mem_i_flush_o(mem_i_flush_w)
    ,.mem_i_invalidate_o(mem_i_invalidate_w)
    ,.mem_i_pc_o(mem_i_pc_w)
    ,.timing_error(timing_error)
);

slave_spi
u_spi
(
    .sclk(spi_clk),
    .clk(clk),
    .cs(spi_cs),
    .mosi(spi_mosi),
    .rstn(!rst),
    .miso(spi_miso),
    .start_flag(p_start_flag),
    .data_rd_i(mem_d_data_rd_w),
    .data_rd_en_o(data_rd_en_o_spi),
    .data_adr_o(data_adr_o_spi),
    .data_wr_o(data_wr_o_spi),
    .data_wr_en_o(data_wr_en_o_spi),
    .mem_ack(mem_d_ack_w),
    .mem_accept(mem_d_accept_w)
);

tcm_mem
u_mem
(
    `ifdef USE_POWER_PINS
	    .vccd1(vccd1),	// User area 1 1.8V power
	    .vssd1(vssd1),	// User area 1 digital ground
    `endif
    // Inputs
     .clk_i(clk)
    ,.rst_i(rst)
    ,.mem_i_rd_i(mem_i_rd_w)
    ,.mem_i_flush_i(mem_i_flush_w)
    ,.mem_i_invalidate_i(mem_i_invalidate_w)
    ,.mem_i_pc_i(mem_i_pc_w)
    ,.mem_d_addr_i(mem_d_addr_w_mux)
    ,.mem_d_data_wr_i(mem_d_data_wr_w_mux)
    ,.mem_d_rd_i(mem_d_rd_w_mux)
    ,.mem_d_wr_i(mem_d_wr_w_mux)
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

endmodule