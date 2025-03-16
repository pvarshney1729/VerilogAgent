module top_module (
    input logic x,
    input logic y,
    input logic clk,
    input logic reset,
    output logic z
);

    logic A1_out, A2_out, B1_out, B2_out;
    logic or_gate_out, and_gate_out;

    // Module A instances
    A A1 (.x(x), .y(y), .z(A1_out));
    A A2 (.x(x), .y(y), .z(A2_out));

    // Module B instances
    B B1 (.clk(clk), .reset(reset), .x(x), .y(y), .z(B1_out));
    B B2 (.clk(clk), .reset(reset), .x(x), .y(y), .z(B2_out));

    // OR gate
    assign or_gate_out = A1_out | B1_out;

    // AND gate
    assign and_gate_out = A2_out & B2_out;

    // XOR gate
    assign z = or_gate_out ^ and_gate_out;

endmodule

module A (
    input logic x,
    input logic y,
    output logic z
);
    assign z = (x ^ y) & x;
endmodule

module B (
    input logic clk,
    input logic reset,  // Synchronous reset
    input logic x,
    input logic y,
    output logic z
);

    logic z_next;

    always_ff @(posedge clk) begin
        if (reset) begin
            z <= 1'b1;  // Initialize as per the waveform at 0ns
        end else begin
            z <= z_next;
        end
    end

    always_comb begin
        case ({x, y})
            2'b00: z_next = 1'b1;  // Based on the waveform for times 0ns - 20ns and 55ns
            2'b01: z_next = 1'b0;  // Based on the waveform for times 35ns - 40ns and 60ns - 85ns
            2'b10: z_next = 1'b0;  // Based on the waveform for times 25ns - 30ns and 90ns
            2'b11: z_next = 1'b1;  // Based on the waveform for times 45ns - 50ns and 70ns
            default: z_next = 1'b0;
        endcase
    end

endmodule