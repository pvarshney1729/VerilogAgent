module counter(
    input logic clk,
    input logic reset_n, // Active low synchronous reset
    output logic [2:0] q
);

    always_ff @(posedge clk) begin
        if (!reset_n) begin
            q <= 3'b000; // Initialize to zero on reset
        end else if (q == 3'b110) begin
            q <= 3'b000; // Wrap around after reaching 3'b110
        end else begin
            q <= q + 1'b1; // Increment counter
        end
    end

endmodule