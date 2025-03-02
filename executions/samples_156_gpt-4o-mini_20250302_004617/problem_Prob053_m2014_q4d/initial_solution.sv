module xor_with_reset (
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);

    logic out_next;

    always @(*) begin
        out_next = in ^ out; // XOR functionality
    end

    always @(posedge clk) begin
        if (reset) begin
            out <= 1'b0; // Synchronous reset
        end else begin
            out <= out_next; // Update output with XOR result
        end
    end

endmodule