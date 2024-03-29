module msrv32_instruction_mux (
    input [31:0] ms_riscv32_mp_instr_in,
    input flush_in,
    output [6:0] opcode_out,
    output [2:0] funct3_out,
    output [6:0] funct7_out,
    output [11:0] csr_addr_out,
    output [4:0] rs1addr_out,
    output [4:0] rs2addr_out,
    output [4:0] rdaddr_out,
    output [24:0] instr_out
);

    // Internal signal to represent either the flushed instruction or the input instruction
    wire [31:0] instr_mux;

    // Mux based on flush_in signal
    assign instr_mux = flush_in ? 32'h00000013 : ms_riscv32_mp_instr_in;

    // Parse the instruction fields
    assign opcode_out   = instr_mux[6:0];
    assign funct3_out   = instr_mux[14:12];
    assign funct7_out   = instr_mux[31:25];
    assign csr_addr_out = instr_mux[31:20];
    assign rs1addr_out  = instr_mux[19:15];
    assign rs2addr_out  = instr_mux[24:20];
    assign rdaddr_out   = instr_mux[11:7];
    assign instr_out    = instr_mux[31:7];

endmodule
