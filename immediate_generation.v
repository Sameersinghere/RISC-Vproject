module immediate_generation (
    input [31:0] instr,    // 32-bit instruction input
    output [31:0] imm_out  // immediate value output
);

// Extracting instruction segments
wire [31:20] i_type = instr[31:20];
wire [31:25] s_type_msb = instr[31:25];
wire [11:7] s_type_lsb = instr[11:7];
wire [31:12] u_type = instr[31:12];
wire [19:15] csr_type = instr[19:15];

// Concatenation logic
assign imm_out = (i_type == 32'b1) ? {i_type, instr[31]} :
                 (s_type_msb == 7'b1) ? {s_type_msb, s_type_lsb, instr[31]} :
                 (u_type == 20'b1) ? {u_type, instr[31]} :
                 (csr_type == 5'b1) ? {csr_type, instr[31]} : 32'b0;

endmodule
