module imm_gen (
    input [31:7] instr_in,         // Instruction bits input
    input [2:0] imm_type_in,       // Immediate type input
    output [31:0] imm_out          // Immediate value output
);

    // Immediate values for different instruction types
    wire [31:0] i_type = {instr_in[11:0], instr_in[11:0]};
    wire [31:0] s_type = {instr_in[11], instr_in[7:0], instr_in[31:25], instr_in[11]};
    wire [31:0] b_type = {instr_in[12], instr_in[10:5], instr_in[4:1], instr_in[11], instr_in[12]};
    wire [31:0] u_type = {instr_in[31:12], 12'b0};
    wire [31:0] j_type = {instr_in[20], instr_in[19:12], instr_in[11], instr_in[10:1], instr_in[20]};
    wire [31:0] csr_type = {instr_in[19:15], 27'b0}; // Assuming csr type has 5-bit immediate

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
