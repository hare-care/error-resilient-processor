
module tcm_mem
(
    `ifdef USE_POWER_PINS
        inout vccd1,
        inout vssd1,
    `endif
    // Inputs
     input           clk_i
    ,input           rst_i
    ,input           mem_i_rd_i
    ,input           mem_i_flush_i
    ,input           mem_i_invalidate_i
    ,input  [ 31:0]  mem_i_pc_i
    ,input  [ 31:0]  mem_d_addr_i
    ,input  [ 31:0]  mem_d_data_wr_i
    ,input           mem_d_rd_i
    ,input  [  3:0]  mem_d_wr_i
    ,input           mem_d_cacheable_i
    ,input  [ 10:0]  mem_d_req_tag_i
    ,input           mem_d_invalidate_i
    ,input           mem_d_writeback_i
    ,input           mem_d_flush_i

    // Outputs
    ,output          mem_i_accept_o
    ,output          mem_i_valid_o
    ,output          mem_i_error_o
    ,output reg [ 63:0]  mem_i_inst_o
    ,output [ 31:0]  mem_d_data_rd_o
    ,output          mem_d_accept_o
    ,output          mem_d_ack_o
    ,output          mem_d_error_o
    ,output [ 10:0]  mem_d_resp_tag_o
);

//-------------------------------------------------------------
// Dual Port RAM
//-------------------------------------------------------------
wire        muxed_hi_w   = mem_d_addr_i[2];
reg [63:0] data_r_w;

wire web1;
wire [63:0]read_mem_i_inst_o;
wire [63:0]read_data_r_w;
tcm_mem_ram 
u_ram 
(
    `ifdef USE_POWER_PINS
	    .vccd1(vccd1),	// User area 1 1.8V power
	    .vssd1(vssd1),	// User area 1 digital ground
    `endif
    .clk0(clk_i),             // Connect clk0 to clk0_signal in your design
    .csb0(1'b0),             // Connect csb0 to csb0_signal
    .web0(1'b1),             // Connect web0 to web0_signal
    .addr0(mem_i_pc_i[7:3]),           // Connect addr0 to addr0_signal
    .wmask0(8'b0),         // Connect wmask0 to wmask0_signal
    .din0(64'b0),             // Connect din0 to din0_signal
    .dout0(read_mem_i_inst_o),           // dout0 will be connected to dout0_signal

    .clk1(clk_i),             // Connect clk1 to clk1_signal
    .csb1(1'b0),             // Connect csb1 to csb1_signal
    .web1(web1),             // Connect web1 to web1_signal
    .addr1(mem_d_addr_i[7:3]),           // Connect addr1 to addr1_signal
    .wmask1(muxed_hi_w ? {mem_d_wr_i, 4'b0} : {4'b0, mem_d_wr_i}),         // Connect wmask1 to wmask1_signal
    .din1(muxed_hi_w ? {mem_d_data_wr_i, 32'b0} : {32'b0, mem_d_data_wr_i}),             // Connect din1 to din1_signal
    .dout1(read_data_r_w)            // dout1 will be connected to dout1_signal
);

assign web1= ~|mem_d_wr_i;
// synchrounous read from ram at pos clock edge

always @(posedge clk_i ) begin
    if (rst_i) begin
        mem_i_inst_o<=64'b0;
        data_r_w<= 64'b0;
    end else begin
        mem_i_inst_o<=read_mem_i_inst_o;
        data_r_w<=read_data_r_w;
    end
end

// tcm_mem_ram
// u_ram
// (
//     // Instruction fetch
//      .clk0_i(clk_i)
//     ,.rst0_i(rst_i)
//     ,.addr0_i(mem_i_pc_i[16:3])
//     ,.data0_i(64'b0)
//     ,.wr0_i(8'b0)

//     // External access / Data access
//     ,.clk1_i(clk_i)
//     ,.rst1_i(rst_i)
//     ,.addr1_i(mem_d_addr_i[16:3])
//     ,.data1_i(muxed_hi_w ? {mem_d_data_wr_i, 32'b0} : {32'b0, mem_d_data_wr_i})
//     ,.wr1_i(muxed_hi_w ? {mem_d_wr_i, 4'b0} : {4'b0, mem_d_wr_i})

//     // Outputs
//     ,.data0_o(mem_i_inst_o)
//     ,.data1_o(data_r_w)
// );

reg muxed_hi_q;

always @ (posedge clk_i )
if (rst_i)
    muxed_hi_q <= 1'b0;
else
    muxed_hi_q <= muxed_hi_w;

//-------------------------------------------------------------
// Instruction Fetch
//-------------------------------------------------------------
reg        mem_i_valid_q;

always @ (posedge clk_i )
if (rst_i)
    mem_i_valid_q <= 1'b0;
else
    mem_i_valid_q <= mem_i_rd_i;

assign mem_i_accept_o  = 1'b1;
assign mem_i_valid_o   = mem_i_valid_q;
assign mem_i_error_o   = 1'b0;

//-------------------------------------------------------------
// Data Access / Incoming external access
//-------------------------------------------------------------
reg        mem_d_accept_q;
reg        mem_d_ack_q;
reg [10:0] mem_d_tag_q;

always @ (posedge clk_i )
if (rst_i)
begin
    mem_d_ack_q    <= 1'b0;
    mem_d_tag_q    <= 11'b0;
end
else if ((mem_d_rd_i || mem_d_wr_i != 4'b0 || mem_d_flush_i || mem_d_invalidate_i || mem_d_writeback_i) && mem_d_accept_o)
begin
    mem_d_ack_q    <= 1'b1;
    mem_d_tag_q    <= mem_d_req_tag_i;
end
else
    mem_d_ack_q    <= 1'b0;

assign mem_d_ack_o          = mem_d_ack_q;
assign mem_d_resp_tag_o     = mem_d_tag_q;
assign mem_d_data_rd_o      = muxed_hi_q ? data_r_w[63:32] : data_r_w[31:0];
assign mem_d_error_o        = 1'b0;

assign mem_d_accept_o       = 1'b1;

//-------------------------------------------------------------
// write: Write byte into memory
//-------------------------------------------------------------
// task write; /*verilator public*/
//     input [31:0] addr;
//     input [7:0]  data;
// begin
//     case (addr[2:0]) // .ram
//     3'd0: u_ram.ram[addr/8][7:0]   = data;
//     3'd1: u_ram.ram[addr/8][15:8]  = data;
//     3'd2: u_ram.ram[addr/8][23:16] = data;
//     3'd3: u_ram.ram[addr/8][31:24] = data;
//     3'd4: u_ram.ram[addr/8][39:32] = data;
//     3'd5: u_ram.ram[addr/8][47:40] = data;
//     3'd6: u_ram.ram[addr/8][55:48] = data;
//     3'd7: u_ram.ram[addr/8][63:56] = data;
//     endcase
// end
// endtask

// task write; /*verilator public*/
//     input [31:0] addr;
//     input [7:0]  data;
// begin
//     case (addr[2:0]) // .ram
//     3'd0: u_ram.mem[addr/8][7:0]   = data;
//     3'd1: u_ram.mem[addr/8][15:8]  = data;
//     3'd2: u_ram.mem[addr/8][23:16] = data;
//     3'd3: u_ram.mem[addr/8][31:24] = data;
//     3'd4: u_ram.mem[addr/8][39:32] = data;
//     3'd5: u_ram.mem[addr/8][47:40] = data;
//     3'd6: u_ram.mem[addr/8][55:48] = data;
//     3'd7: u_ram.mem[addr/8][63:56] = data;
//     endcase
// end
// endtask
endmodule
