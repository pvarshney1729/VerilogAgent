[BEGIN]
module TopModule(
    input logic clk,
    input logic reset,
    output logic [3:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0001; // Reset state to 1
    end else begin
        if (q == 4'b1010) begin
            q <= 4'b0001; // Roll over to 1 after 10
        end else begin
            q <= q + 4'b0001; // Increment counter
        end
    end
end

endmodule
[DONE]