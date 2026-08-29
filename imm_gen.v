module imm_gen (
    input [31:7] instr_in,         // Instruction bits input
    input [2:0] imm_type_in,       // Immediate type input
    output reg [31:0] imm_out      // Immediate value output
);

    // RISC-V immediate encodings. instr_in maps to instruction bits [31:7].
    wire [31:0] i_type   = {{20{instr_in[31]}}, instr_in[31:20]};
    wire [31:0] s_type   = {{20{instr_in[31]}}, instr_in[31:25], instr_in[11:7]};
    wire [31:0] b_type   = {{19{instr_in[31]}}, instr_in[31], instr_in[7],
                            instr_in[30:25], instr_in[11:8], 1'b0};
    wire [31:0] u_type   = {instr_in[31:12], 12'b0};
    wire [31:0] j_type   = {{11{instr_in[31]}}, instr_in[31], instr_in[19:12],
                            instr_in[20], instr_in[30:21], 1'b0};
    wire [31:0] csr_type = {27'b0, instr_in[19:15]};

    // Multiplexer to select the correct immediate type
    always @(*) begin
        case(imm_type_in)
            3'b000: imm_out = i_type;
            3'b001: imm_out = s_type;
            3'b010: imm_out = b_type;
            3'b011: imm_out = u_type;
            3'b100: imm_out = j_type;
            3'b101: imm_out = csr_type;
            default: imm_out = 32'b0;
        endcase
    end

endmodule
