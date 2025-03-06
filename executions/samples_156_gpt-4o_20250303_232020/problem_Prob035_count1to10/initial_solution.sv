module TopModule(
    input logic clk,
    input logic reset,
    output logic [3:0] q
);

always_ff @(posedge clk) begin
    if (reset) begin
        q <= 4'b0001; // Reset state
    end else begin
        if (q == 4'b1010) begin
            q <= 4'b0001; // Roll over to 1 after reaching 10
        end else begin
            q <= q + 1;
        end
    end
end

endmodule