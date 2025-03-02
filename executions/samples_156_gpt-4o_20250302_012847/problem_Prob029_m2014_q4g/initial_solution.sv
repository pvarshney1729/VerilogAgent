module combinational_logic (
    input logic clk,
    input logic reset,
    input logic a,
    input logic b,
    output logic y
);

    logic xnor_result;
    logic xor_result;

    // Combinational logic for XNOR followed by XOR
    always @(*) begin
        xnor_result = ~(a ^ b); // XNOR operation
        xor_result = xnor_result ^ a; // XOR operation with one of the inputs
    end

    // Sequential logic with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            y <= 1'b0; // Initialize output to zero on reset
        end else begin
            y <= xor_result; // Assign the result to output
        end
    end

endmodule