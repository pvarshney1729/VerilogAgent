[BEGIN]
module TopModule(
    input logic clk,
    input logic w,
    input logic R,
    input logic E,
    input logic L,
    output logic Q
);

always @(posedge clk) begin
    if (R) begin
        Q <= 1'b0; // Synchronous reset
    end else if (L) begin
        Q <= w;    // Load w if L is asserted
    end else if (E) begin
        Q <= w;    // Shift w if E is asserted and L is not asserted
    end
    // If neither R, L, nor E is asserted, Q retains its value automatically
end

endmodule
[DONE]