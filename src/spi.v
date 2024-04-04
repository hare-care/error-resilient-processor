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
    input sclk, cs, mosi, rstn,
    output miso
);

reg [39:0] data_store;


always @(posedge sclk) begin
    if (!rstn) begin
        data_store <= 40'b0;
    end
    else begin
        data_store <= mosi;
    end  
end

endmodule