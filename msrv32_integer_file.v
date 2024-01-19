module msrv32_integer_file (
    input ms_riscv32_mp_clk_in,
    input ms_riscv32_mp_rst_in,
    input [4:0] rs1_addr_in,
    input [4:0] rs2_addr_in,
    input [4:0] rd_addr_in,
    input wr_en_in,
    input [31:0] rd_in,
    output [31:0] rs1_out,
    output [31:0] rs2_out
);

    // Assuming 32 registers for the RISC-V register file
    reg [31:0] register_file [31:0];

    always @(posedge ms_riscv32_mp_clk_in or posedge ms_riscv32_mp_rst_in) begin
        if (ms_riscv32_mp_rst_in) begin
            // Reset logic: Clearing all registers (can be modified as per requirement)
            for (integer i = 0; i < 32; i = i + 1) begin
                register_file[i] <= 32'b0;
            end
        end else if (wr_en_in) begin
            // Write to the register file if write enable is asserted
            register_file[rd_addr_in] <= rd_in;
        end
    end

    // Read from the register file
    assign rs1_out = register_file[rs1_addr_in];
    assign rs2_out = register_file[rs2_addr_in];

endmodule
