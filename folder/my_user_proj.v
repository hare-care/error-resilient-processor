// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none
/*
 *-------------------------------------------------------------
 *
 * user_proj_example
 *
 * This is an example of a (trivially simple) user project,
 * showing how the user project can connect to the logic
 * analyzer, the wishbone bus, and the I/O pads.
 *
 * This project generates an integer count, which is output
 * on the user area GPIO pads (digital output only).  The
 * wishbone connection allows the project to be controlled
 * (start and stop) from the management SoC program.
 *
 * See the testbenches in directory "mprj_counter" for the
 * example programs that drive this user project.  The three
 * testbenches are "io_ports", "la_test1", and "la_test2".
 *
 *-------------------------------------------------------------
 */

module my_user_proj #(
    parameter BITS = 32
)(
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    // IOs
    input  [BITS-1:0] io_in,
    output [BITS-1:0] io_out,
    output [BITS-1:0] io_oeb,

    // IRQ
    output [2:0] irq
);
    wire clk;
    wire rst;

    wire [BITS-1:0] rdata; 
    wire [BITS-1:0] wdata;
    wire [BITS-1:0] count;

    wire valid;
    wire [3:0] wstrb;
    wire [BITS-1:0] la_write;

    // WB MI A
    assign valid = wbs_cyc_i && wbs_stb_i; 
    assign wstrb = wbs_sel_i & {4{wbs_we_i}};
    assign wbs_dat_o = {{(32-BITS){1'b0}}, rdata};
    assign wdata = wbs_dat_i[BITS-1:0];

    // IO
    assign io_out = count;
    assign io_oeb = {(BITS){rst}};

    // IRQ
    assign irq = 3'b000;	// Unused

    // LA
    assign la_data_out = {{(128-BITS){1'b0}}, count};
    // Assuming LA probes [63:32] are for controlling the count register  
    assign la_write = ~la_oenb[63:64-BITS] & ~{BITS{valid}};
    // Assuming LA probes [65:64] are for controlling the count clk & reset  
    assign clk = (~la_oenb[64]) ? la_data_in[64]: wb_clk_i;
    assign rst = (~la_oenb[65]) ? la_data_in[65]: wb_rst_i;

    // counter #(
    //     .BITS(BITS)
    // ) counter(
    //     .clk(clk),
    //     .reset(rst),
    //     .ready(wbs_ack_o),
    //     .valid(valid),
    //     .rdata(rdata),
    //     .wdata(wbs_dat_i[BITS-1:0]),
    //     .wstrb(wstrb),
    //     .la_write(la_write),
    //     .la_input(la_data_in[63:64-BITS]),
    //     .count(count)
    // );



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
assign instruction=mem_i_inst_w;
assign pc=mem_i_pc_w;
assign data_write=mem_d_data_wr_w;
assign data_read=mem_d_data_rd_w;


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
riscv_core
u_core
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
    ,.rst_i(rst)
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
);


wire [63:0] in_data_imm,in_data;
wire[4:0] in_addr;
/*concate 2 32 bits input to 64 bits*/
always @(posedge clk ) begin
    if (reset) begin
        in_data_imm<=64'b0;
        in_data<=64'b0;
    end
    else begin
        in_data<=64'b0;
        if (count[0]==1'b0) begin
            in_data_imm[31:0]<= la_write & la_input;
        end
        else begin
            in_data_imm[63:32]<=la_write & la_input;
            in_data<=in_data_imm;
        end
    end
end
assign in_addr=(|la_write)? (count[5:0]/2):mem_i_pc_i[7:3];//2 cycles for 1 address
tcm_mem_ram 
u_ram 
(
    `ifdef USE_POWER_PINS
	    .vccd1(vccd1),	// User area 1 1.8V power
	    .vssd1(vssd1),	// User area 1 digital ground
    `endif
    .clk0(clk_i),             // Connect clk0 to clk0_signal in your design
    .csb0(1'b0),             // Connect csb0 to csb0_signal
    .web0(|la_write),             // Connect web0 to web0_signal
    .addr0(in_addr),           // Connect addr0 to addr0_signal
    .wmask0(wstrb[7:0]),         // Connect wmask0 to wmask0_signal
    .din0(in_addr),             // Connect din0 to din0_signal
    .dout0(read_mem_i_inst_o),           // dout0 will be connected to dout0_signal

    .clk1(clk_i),             // Connect clk1 to clk1_signal
    .csb1(1'b0),             // Connect csb1 to csb1_signal
    .web1(web1),             // Connect web1 to web1_signal
    .addr1(mem_d_addr_i[7:3]),           // Connect addr1 to addr1_signal
    .wmask1(muxed_hi_w ? {mem_d_wr_i, 4'b0} : {4'b0, mem_d_wr_i}),         // Connect wmask1 to wmask1_signal
    .din1(muxed_hi_w ? {mem_d_data_wr_i, 32'b0} : {32'b0, mem_d_data_wr_i}),             // Connect din1 to din1_signal
    .dout1(read_data_r_w)            // dout1 will be connected to dout1_signal
);

endmodule

module counter #(
    parameter BITS = 16
)(
    input clk,
    input reset,
    input valid,
    input [3:0] wstrb,
    input [BITS-1:0] wdata,
    input [BITS-1:0] la_write,
    input [BITS-1:0] la_input,
    output reg ready,
    output reg [BITS-1:0] rdata,
    output reg [BITS-1:0] count
);
    always @(posedge clk) begin
        if (reset) begin
            count <= 1'b0;
            ready <= 1'b0;
        end else begin
            ready <= 1'b0;
            if (~|la_write) begin
                count <= count + 1'b1;
            end
            if (valid && !ready) begin
                ready <= 1'b1;
                rdata <= count;
                if (wstrb[0]) count[7:0]   <= wdata[7:0];
                if (wstrb[1]) count[15:8]  <= wdata[15:8];
            end else if (|la_write) begin
                count <= la_write & la_input;
            end
        end
    end

endmodule
`default_nettype wire
