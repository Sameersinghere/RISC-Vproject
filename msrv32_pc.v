module msrv32_pc (
    input rst_in,
    input [1:0] pc_src_in,
    input [31:0] epc_in,
    input [31:0] trap_address_in,
    input branch_taken_in,
    input [31:0] iaddr_in,
    input ahb_ready_in,
    input [31:0] pc_in,
    
    output [31:0] iaddr_out,
    output [31:0] pc_plus_4_out,
    output [31:0] misaligned_instr_out,
    output [31:0] pc_mux_out
);

    parameter BOOT_ADDRESS = 32'h00000000;  // Define this with your actual boot address

    wire [31:0] pc_plus_4;
    wire [31:0] iaddr_concat;
    wire [31:0] mux_select[3:0];  // Four inputs for 4x1 MUX

    // PC incremented by 4
    assign pc_plus_4 = pc_in + 32'h0000_0004;

    // iaddr concatenation with 1'b0
    assign iaddr_concat = {iaddr_in[31:1], 1'b0};

    // MUX inputs assignment based on the core's current state
    assign mux_select[0] = (rst_in) ? BOOT_ADDRESS : ((branch_taken_in && !ahb_ready_in) ? iaddr_concat : pc_plus_4);
    assign mux_select[1] = epc_in;
    assign mux_select[2] = trap_address_in;
    assign mux_select[3] = iaddr_concat;

    // Misaligned instruction logic
    assign misaligned_instr_out = branch_taken_in && pc_in[0];

    // PC MUX logic
    always @(pc_src_in) begin
        case(pc_src_in)
            2'b00: pc_mux_out = mux_select[0];
            2'b01: pc_mux_out = mux_select[1];
            2'b10: pc_mux_out = mux_select[2];
            2'b11: pc_mux_out = mux_select[3];
            default: pc_mux_out = 32'h0000_0000;  // default value
        endcase
    end

    assign iaddr_out = (rst_in) ? BOOT_ADDRESS : ((ahb_ready_in) ? pc_mux_out : BOOT_ADDRESS);
    assign pc_plus_4_out = pc_plus_4;

endmodule

