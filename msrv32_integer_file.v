module msrv32_integer_file (
    input ms_riscv32_mp_clk_in,
    input ms_riscv32_mp_rst_in,
    input [4:0] rs1_addr_in,
    input [4:0] rs2_addr_in,
    input [4:0] rd_addr_in,
    input wr_en_in,
    input [31:0] rd_in,
    output reg [31:0] rs1_out,
    output reg [31:0] rs2_out
);

    reg [31:0] register_file [31:0];

    always @(posedge ms_riscv32_mp_clk_in or posedge ms_riscv32_mp_rst_in) begin
        if (ms_riscv32_mp_rst_in) begin
            // Reset all registers to 0
            for (integer i = 0; i < 32; i = i + 1) begin
                register_file[i] <= 32'b0;
            end
        end else if (wr_en_in && rd_addr_in != 5'b00000) begin
            // Write to the register file (except to register 0)
            register_file[rd_addr_in] <= rd_in;
        end
    end

    always @(*) begin
        // Directly forward data if there's a data hazard
        if (wr_en_in && rs1_addr_in == rd_addr_in) 
            rs1_out = rd_in;
        else
            rs1_out = register_file[rs1_addr_in];

        if (wr_en_in && rs2_addr_in == rd_addr_in) 
            rs2_out = rd_in;
        else
            rs2_out = register_file[rs2_addr_in];
    end

endmodule
