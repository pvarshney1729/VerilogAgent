module TopModule(
    input logic clk,
    input logic a,
    input logic reset,
    output logic q
);

always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 1'b0; // Asynchronous reset to initial state
    end else if (a) begin
        q <= ~q; // Toggle state on positive edge of clk if a is 1
    end
end

endmodule