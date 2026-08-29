module immediate_generation (
    input [31:0] instr,    // 32-bit instruction input
    output [31:0] imm_out  // immediate value output
);

wire [2:0] imm_type;

// Decode the common RV32I immediate format from the opcode.
assign imm_type =
    (instr[6:0] == 7'b0100011) ? 3'b001 : // S-type
    (instr[6:0] == 7'b1100011) ? 3'b010 : // B-type
    (instr[6:0] == 7'b0110111 ||
     instr[6:0] == 7'b0010111) ? 3'b011 : // U-type
    (instr[6:0] == 7'b1101111) ? 3'b100 : // J-type
    (instr[6:0] == 7'b1110011) ? 3'b101 : // CSR immediate
                                  3'b000;  // I-type/default

imm_gen u_imm_gen (
    .instr_in(instr[31:7]),
    .imm_type_in(imm_type),
    .imm_out(imm_out)
);

endmodule
