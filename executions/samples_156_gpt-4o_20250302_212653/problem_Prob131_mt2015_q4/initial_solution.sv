module top_module (
    input logic x,
    input logic y,
    input logic clk,  // Added clock input
    output logic z
);

    logic a1_out, a2_out, b1_out, b2_out;
    logic or_out, and_out;

    // Instantiate Module A
    module_a a1 (
        .x(x),
        .y(y),
        .z(a1_out)
    );

    module_a a2 (
        .x(x),
        .y(y),
        .z(a2_out)
    );

    // Instantiate Module B
    module_b b1 (
        .clk(clk),  // Connect clock to module B
        .x(x),
        .y(y),
        .z(b1_out)
    );

    module_b b2 (
        .clk(clk),  // Connect clock to module B
        .x(x),
        .y(y),
        .z(b2_out)
    );

    // OR gate
    assign or_out = a1_out | b1_out;

    // AND gate
    assign and_out = a2_out & b2_out;

    // XOR gate
    assign z = or_out ^ and_out;

endmodule

module module_a (
    input logic x,
    input logic y,
    output logic z
);
    always @(*) begin
        z = (x ^ y) & x;
    end
endmodule

module module_b (
    input logic clk,  // Added clock input
    input logic x,
    input logic y,
    output logic z
);
    logic [1:0] state;
    always_ff @(posedge clk) begin
        case (state)
            2'b00: z <= 1;
            2'b01: z <= 0;
            2'b10: z <= 0;
            2'b11: z <= 1;
            default: z <= 1;
        endcase
    end

    always_ff @(posedge clk) begin
        state <= {x, y};
    end
endmodule