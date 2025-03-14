module TopModule (
    input logic clk,
    input logic reset,
    output logic [3:0] q
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000; // Reset to zero
        end else begin
            if (q == 4'b1111) begin
                q <= 4'b0000; // Wrap around
            end else begin
                q <= q + 1'b1; // Increment
            end
        end
    end

endmodule