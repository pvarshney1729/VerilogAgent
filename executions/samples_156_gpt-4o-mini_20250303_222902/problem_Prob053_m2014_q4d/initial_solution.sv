module TopModule (
    input logic clk,     // Clock signal, 1-bit
    input logic in,      // Input signal, 1-bit
    output logic out     // Output signal, 1-bit, driven by a D flip-flop
);

    initial begin
        out = 1'b0; // Initialize output to 0
    end

    always @(*) begin
        logic xor_out;
        xor_out = in ^ out; // XOR operation
    end

    always @(posedge clk) begin
        out <= xor_out; // D flip-flop operation
    end

endmodule