module tb_imm_gen;
    reg [31:0] instr;
    wire [31:0] imm;

    immediate_generation dut (
        .instr(instr),
        .imm_out(imm)
    );

    initial begin
        $dumpfile("build/tb_imm_gen.vcd");
        $dumpvars(0, tb_imm_gen);
    end

    initial begin
        instr = 32'hfff10093; #1; // addi x1, x2, -1
        if (imm !== 32'hffff_ffff) $fatal(1, "I-type immediate failed: %h", imm);

        instr = 32'h00112e23; #1; // sw x1, 28(x2)
        if (imm !== 32'd28) $fatal(1, "S-type immediate failed: %h", imm);

        instr = 32'h0000006f; #1; // jal x0, 0
        if (imm !== 32'd0) $fatal(1, "J-type immediate failed: %h", imm);

        $display("tb_imm_gen passed");
    end
endmodule
