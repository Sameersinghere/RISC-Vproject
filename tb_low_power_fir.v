module tb_low_power_fir;
    reg clk;
    reg rst;
    reg valid;
    reg signed [15:0] sample;
    wire out_valid;
    wire signed [33:0] result;

    low_power_fir dut (
        .clk_in(clk),
        .rst_in(rst),
        .sample_valid_in(valid),
        .sample_in(sample),
        .coeff0_in(16'sd1),
        .coeff1_in(16'sd2),
        .coeff2_in(16'sd3),
        .coeff3_in(16'sd4),
        .result_valid_out(out_valid),
        .result_out(result)
    );

    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("build/tb_low_power_fir.vcd");
        $dumpvars(0, tb_low_power_fir);
    end

    task push_sample;
        input signed [15:0] value;
        input signed [33:0] expected;
        begin
            @(negedge clk);
            valid = 1'b1;
            sample = value;
            @(posedge clk);
            #1;
            if (!out_valid) $fatal(1, "Expected valid output");
            if (result !== expected) $fatal(1, "Expected %0d got %0d", expected, result);
            @(negedge clk);
            valid = 1'b0;
        end
    endtask

    initial begin
        rst = 1'b1;
        valid = 1'b0;
        sample = 16'sd0;
        repeat (2) @(posedge clk);
        rst = 1'b0;

        push_sample(16'sd1, 34'sd1);
        push_sample(16'sd2, 34'sd4);
        push_sample(16'sd3, 34'sd10);
        push_sample(16'sd4, 34'sd20);

        @(negedge clk);
        valid = 1'b0;
        sample = 16'sd99;
        repeat (2) @(posedge clk);
        if (out_valid) $fatal(1, "FIR should gate output when sample_valid is low");

        $display("tb_low_power_fir passed");
        $finish;
    end
endmodule
