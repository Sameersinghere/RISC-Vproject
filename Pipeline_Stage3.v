module Pipeline_Stage3 (
    // Inputs
    input [31:0] ms_risc32_mp_dmdata_in, 
    input [1:0] iadder_u1_to_lu_in,
    input load_unsigned_in,
    input [1:0] load_stre_in,
    input [31:0] op_1_in,
    input [31:0] op_2_in,
    input [5:0] opcode_in,
    input abh_resp_in,
    
    // Outputs
    output [31:0] wb_mux_out,
    output [31:0] alu_2nd_src_mux_out
);

    // Internal wires
    wire [31:0] lu_output;
    wire [31:0] alu_result;
    wire [2:0] wb_mux_sel_reg;
    wire [31:0] alu_src_reg;
    wire [31:0] iadder_out_reg;
    wire [31:0] csr_data_in;
    wire [31:0] pc_plus_4_reg;
    wire [31:0] rs2_reg_in;
    
    // ALU module
    msrv32_alu ALU (
        .op_1_in(op_1_in),
        .op_2_in(op_2_in),
        .opcode_in(opcode_in),
        .result_out(alu_result)
    );
    
    // Load Unit module
    msrv32_load_unit LU (
        .ms_risc32_mp_dmdata_in(ms_risc32_mp_dmdata_in),
        .iadder_u1_to_lu_in(iadder_u1_to_lu_in),
        .load_unsigned_in(load_unsigned_in),
        .load_stre_in(load_stre_in),
        .lu_output_out(lu_output)
    );
    
    // WB Mux Selector Unit module
    msrv32_wb_mux_sel_unit WB_MUX_SEL (
        .wb_mux_sel_reg_in(wb_mux_sel_reg),
        .alu_src_reg_in(alu_src_reg),
        .alu_result_in(alu_result),
        .lu_output_in(lu_output),
        .iadder_out_reg_in(iadder_out_reg),
        .csr_data_in(csr_data_in),
        .pc_plus_4_reg_in(pc_plus_4_reg),
        .rs2_reg_in(rs2_reg_in),
        .wb_mux_out(wb_mux_out),
        .alu_2nd_src_mux_out(alu_2nd_src_mux_out)
    );

endmodule
