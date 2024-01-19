module pipeline_stage_1(
    // Inputs
    input ms_riscv32_mp_rst_in,
    input [1:0] pc_src_in,
    input [31:0] pc_in,
    input epc_in,
    input [31:0] trap_address_in,
    input branch_taken_in,
    input [1:0] iaddr_in,
    input ahb_ready_in,
    input ms_riscv32_mp_clk_in,

    // Outputs
    output [31:0] ms_riscv32_mp_imaddr_out,
    output pc_out
);

    // Internal signals
    wire [31:0] pc_plus_4_out;
    wire [31:0] misaligned_instr_out;
    wire pc_mux_out;

    // msrv32_pc_mux instantiation
    msrv32_pc_mux pc_mux (
        .ms_riscv32_mp_rst_in(ms_riscv32_mp_rst_in),
        .pc_src_in(pc_src_in),
        .pc_in(pc_in),
        .epc_in(epc_in),
        .trap_address_in(trap_address_in),
        .branch_taken_in(branch_taken_in),
        .iaddr_in(iaddr_in),
        .ahb_ready_in(ahb_ready_in),

        // Outputs
        .ms_riscv32_mp_imaddr_out(ms_riscv32_mp_imaddr_out),
        .pc_plus_4_out(pc_plus_4_out),
        .misaligned_instr_out(misaligned_instr_out),
        .pc_mux_out(pc_mux_out)
    );

    // msrv32_reg_block_1 instantiation
    msrv32_reg_block_1 reg_block_1 (
        .pc_mux_in(pc_mux_out),
        .ms_riscv32_mp_clk_in(ms_riscv32_mp_clk_in),
        .ms_riscv32_mp_rst_in(ms_riscv32_mp_rst_in),

        // Outputs
        .pc_out(pc_out)
    );

endmodule

// Definitions for msrv32_pc_mux and msrv32_reg_block_1 should be provided separately.

