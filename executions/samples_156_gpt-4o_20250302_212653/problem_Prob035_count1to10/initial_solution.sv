module TopModule (
    input logic clk,
    input logic reset,
    output logic [3:0] q
);

always_ff @(posedge clk) begin
    if (reset) begin
        q <= 4'b0001; // Reset to 1
    end else begin
        if (q == 4'b1010) begin
            q <= 4'b0001; // Wrap around to 1
        end else begin
            q <= q + 1; // Increment counter
        end
    end
end

endmodule