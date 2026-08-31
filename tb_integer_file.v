module tb_integer_file;
    reg clk;
    reg rst;
    reg [4:0] rs1;
    reg [4:0] rs2;
    reg [4:0] rd;
    reg wr_en;
    reg [31:0] rd_data;
    wire [31:0] rs1_data;
    wire [31:0] rs2_data;

    msrv32_integer_file dut (
        .ms_riscv32_mp_clk_in(clk),
        .ms_riscv32_mp_rst_in(rst),
        .rs1_addr_in(rs1),
        .rs2_addr_in(rs2),
        .rd_addr_in(rd),
        .wr_en_in(wr_en),
        .rd_in(rd_data),
        .rs1_out(rs1_data),
        .rs2_out(rs2_data)
    );

    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("build/tb_integer_file.vcd");
        $dumpvars(0, tb_integer_file);
    end

    initial begin
        rst = 1'b1;
        wr_en = 1'b0;
        rs1 = 5'd0;
        rs2 = 5'd0;
        rd = 5'd0;
        rd_data = 32'd0;
        repeat (2) @(posedge clk);
        rst = 1'b0;

        @(negedge clk);
        rd = 5'd3;
        rd_data = 32'h1234_abcd;
        wr_en = 1'b1;
        @(posedge clk);
        #1;
        rs1 = 5'd3;
        #1;
        if (rs1_data !== 32'h1234_abcd) $fatal(1, "Register write/read failed");

        @(negedge clk);
        rd = 5'd0;
        rd_data = 32'hffff_ffff;
        wr_en = 1'b1;
        rs1 = 5'd0;
        @(posedge clk);
        #1;
        if (rs1_data !== 32'd0) $fatal(1, "x0 must stay zero");

        $display("tb_integer_file passed");
        $finish;
    end
endmodule
