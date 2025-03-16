[BEGIN]
module TopModule (
    input logic clk,
    input logic d,
    output logic q
);
    always @(posedge clk) begin
        q <= d; // This is correct for sequential logic (D flip-flop)
    end
endmodule
[DONE]