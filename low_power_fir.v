module low_power_fir #(
    parameter DATA_WIDTH = 16,
    parameter COEFF_WIDTH = 16,
    parameter TAP_COUNT = 4
) (
    input clk_in,
    input rst_in,
    input sample_valid_in,
    input signed [DATA_WIDTH-1:0] sample_in,
    input signed [COEFF_WIDTH-1:0] coeff0_in,
    input signed [COEFF_WIDTH-1:0] coeff1_in,
    input signed [COEFF_WIDTH-1:0] coeff2_in,
    input signed [COEFF_WIDTH-1:0] coeff3_in,
    output reg result_valid_out,
    output reg signed [DATA_WIDTH+COEFF_WIDTH+1:0] result_out
);

    reg signed [DATA_WIDTH-1:0] delay_q [0:TAP_COUNT-1];
    wire fir_clk_en = sample_valid_in;

    integer i;

    always @(posedge clk_in or posedge rst_in) begin
        if (rst_in) begin
            for (i = 0; i < TAP_COUNT; i = i + 1) begin
                delay_q[i] <= {DATA_WIDTH{1'b0}};
            end
            result_valid_out <= 1'b0;
            result_out <= {(DATA_WIDTH+COEFF_WIDTH+2){1'b0}};
        end else begin
            result_valid_out <= fir_clk_en;

            if (fir_clk_en) begin
                delay_q[0] <= sample_in;
                delay_q[1] <= delay_q[0];
                delay_q[2] <= delay_q[1];
                delay_q[3] <= delay_q[2];

                result_out <= (sample_in   * coeff0_in) +
                              (delay_q[0]  * coeff1_in) +
                              (delay_q[1]  * coeff2_in) +
                              (delay_q[2]  * coeff3_in);
            end
        end
    end

endmodule
