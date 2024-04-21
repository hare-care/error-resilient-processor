module error_handling (
    input clk,
    input nrst,
    input error_csr,
    input error_divider,
    input error_exec,
    input error_frontend,
    input error_issue,
    input error_lsu,
    input error_mmu,
    input error_multiplier,
    output reg error_out
);

reg error_d_stage, error_e_stage,error_f_stage,error_i_stage,error_l_stage,error_mm_stage,error_m_stage;
always @(posedge clk or negedge nrst) begin
    if (!nrst) begin
        error_out<= 1'b0;
        error_d_stage<=1'b0;
        error_e_stage<=1'b0;
        error_f_stage<=1'b0;
        error_i_stage<=1'b0;
        error_l_stage<=1'b0;
        error_mm_stage<=1'b0;
        error_m_stage<=1'b0;
        error_out<=1'b0;
    end
    else begin
        error_d_stage<=error_divider|error_csr;
        error_e_stage<=error_d_stage|error_exec;
        error_f_stage<=error_e_stage|error_frontend;
        error_i_stage<=error_f_stage|error_issue;
        error_l_stage<=error_i_stage|error_lsu;
        error_mm_stage<=error_l_stage|error_mmu;
        error_m_stage<=error_mm_stage|error_multiplier;
        error_out<=error_m_stage;
    end
end

endmodule