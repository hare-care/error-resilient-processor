`timescale 1ns / 1ns
// fpga on the outside
module master_spi #(
    parameter width = 5
)
(
    input clk, miso, rstn,
    output mosi, sclk
);

wire pass;




endmodule


// inside the cpu
module slave_spi #(
    parameter width = 5
)
(
    input clk, sclk, cs, mosi, rstn,
    input mem_ack, mem_accept,
    input [31:0] data_rd_i,
    output reg miso, start_flag, mem_d_rd_o,
    output reg [31:0] data_adr_o, data_wr_o,
    output reg [3:0] data_wr_en_o

);

localparam s0 = 3'b000;
localparam s1 = 3'b001;
localparam s2 = 3'b010;
localparam s3 = 3'b011;
localparam s4 = 3'b100;
localparam s5 = 3'b101;
localparam s6 = 3'b110;
localparam s7 = 3'b111;
reg [2:0] state, state_c;

reg [71:0] data_store;
reg [71:0] data_store_c;
reg [2:0] sync;
reg [31:0] data_adr, data_adr_c;
reg start_flag_c;
reg [2:0] read_sync;
reg out_flag_c;
wire valid;

assign valid = !sync[2] & sync[1];


// if !cs then accept data, else hold

always @(posedge sclk or negedge rstn) begin
    if (!rstn) begin
        data_store <= 72'b0;
        read_sync <= 2'b0;
    end
    else begin
        data_store[71:0] <= data_store_c[71:0];
        read_sync[2:1] <= read_sync[1:0];
        read_sync[0] <= out_flag_c;
    end
end

always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        state <= s0;
        sync <= 3'b111;
        start_flag <= 1'b0;
        
        data_adr <= 32'b0;
    end
    else begin
        start_flag <= start_flag_c;
        
        state      <= state_c;
        sync[2:1]  <= sync[1:0];
        sync[0]    <= cs;
        data_adr <= data_adr_c;

    end
end


always @(*) begin
    state_c = state;
    miso = 1'b0;
    start_flag_c = start_flag;
    out_flag_c = 1'b0;
    data_adr_o = data_adr_c;
    data_wr_o = 32'b0;
    mem_d_rd_o = 1'b0;
    data_wr_en_o = 4'b0;
    data_adr_c = data_adr;

    if (!cs) begin
        data_store_c[71:1] = data_store[70:0];
        data_store_c[0] = mosi;
    end else if (read_sync == 3'b111) begin 
        data_store_c[71:1] = data_store[70:0];
        data_store_c[0] = 1'b0;
        miso = data_store[71];
    end else begin 
        data_store_c[71:0] = data_store[71:0];
    end

    case (state)
        s0: begin
           // collecting data
           if (valid) begin
            state_c = s1;
           end
        end
        s1: begin
            // buffer phase to figure out what to do
            case (data_store[71:64])
                8'b01: begin
                    state_c = s2;
                end
                8'b10: begin
                    state_c = s3;
                end
                8'b11: begin
                    state_c = s5;
                end
                default: begin
                    state_c = s0;
                end
            endcase
        end
        s2: begin
            // load into memory    data then address
            data_adr_c = data_store[63:32];
            data_wr_o = data_store[31:0];
            data_wr_en_o = 4'b1111;
            miso = 1'b0;
            if (mem_ack) begin
                state_c = s0;
            end else begin
                state_c = state;
            end
        end
        s3: begin
            // read out memory - getting data out of memory
            data_adr_c = data_store[63:32];
            mem_d_rd_o = 1'b1;
            state_c = s6;
        end
        s6: begin
            //out_flag_c = 1'b1;
            mem_d_rd_o = 1'b1;
            //if (out_flag) begin
            state_c = s7;
            //end else begin
            //    state_c = s6;
            //end
        end
        s7: begin
            mem_d_rd_o = 1'b1;
            out_flag_c = 1'b1;
            data_store_c[71:68] = 4'b0; 
            data_store_c[67:64] = 4'b1111;
            data_store_c[63:32] = data_store[63:32];
            data_store_c[31:0] = data_rd_i;
            if (read_sync == 3'b111) begin
                state_c = s4;
            end else begin
                state_c = s7;
            end
        end
        s4: begin
            // read out memory - sending data via SPI
            out_flag_c = 1'b1;
            if (!cs) begin
                state_c = s0;
            end
            state_c = s4;
        end
        s5: begin
            // start the processor
            start_flag_c = 1'b1;
            state_c = s0;
        end
    endcase



end

endmodule