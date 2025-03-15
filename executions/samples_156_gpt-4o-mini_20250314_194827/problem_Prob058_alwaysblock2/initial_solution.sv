module xor_with_ff (
    input logic a,
    input logic b,
    input logic clk,
    input logic reset,
    output logic xor_out,
    output logic ff_out
);

    // Combinational logic for XOR operation
    assign xor_out = a ^ b;

    // Flip-flop with synchronous reset
    always @(*) begin
        if (reset) begin
            ff_out = 1'b0; // Asynchronous reset to 0
        end else begin
            ff_out = ff_out; // Retain previous value
        end
    end

    // Sequential logic for flip-flop
    always @(posedge clk) begin
        if (reset) begin
            ff_out <= 1'b0; // Reset on clock edge
        end else begin
            ff_out <= xor_out; // Capture XOR output
        end
    end

endmodule