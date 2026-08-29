module riscv_fir_accelerator_top (
    input clk_in,
    input rst_in,
    input [31:0] instr_in,
    input flush_in,
    input fir_sample_valid_in,
    input signed [15:0] fir_sample_in,
    output [6:0] opcode_out,
    output [4:0] rs1addr_out,
    output [4:0] rs2addr_out,
    output [4:0] rdaddr_out,
    output fir_result_valid_out,
    output signed [33:0] fir_result_out
);

    wire [2:0] funct3_unused;
    wire [6:0] funct7_unused;
    wire [11:0] csr_addr_unused;
    wire [24:0] instr_payload_unused;

    msrv32_instruction_mux u_instruction_mux (
        .ms_riscv32_mp_instr_in(instr_in),
        .flush_in(flush_in),
        .opcode_out(opcode_out),
        .funct3_out(funct3_unused),
        .funct7_out(funct7_unused),
        .csr_addr_out(csr_addr_unused),
        .rs1addr_out(rs1addr_out),
        .rs2addr_out(rs2addr_out),
        .rdaddr_out(rdaddr_out),
        .instr_out(instr_payload_unused)
    );

    low_power_fir u_fir (
        .clk_in(clk_in),
        .rst_in(rst_in),
        .sample_valid_in(fir_sample_valid_in),
        .sample_in(fir_sample_in),
        .coeff0_in(16'sd1),
        .coeff1_in(16'sd2),
        .coeff2_in(16'sd3),
        .coeff3_in(16'sd4),
        .result_valid_out(fir_result_valid_out),
        .result_out(fir_result_out)
    );

endmodule
