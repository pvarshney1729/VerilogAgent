module TopModule (
    input logic clk,
    input logic a,
    output logic q
);

always @(posedge clk) begin
    if (a == 0) begin
        // Maintain current state
        q <= q;
    end else begin
        // Toggle logic based on previous state
        if (q == 0) begin
            q <= 1; // Set when q was 0
        end else begin
            q <= 0; // Reset when q was 1
        end
    end
end

endmodule