module TopModule (
    input logic clk,
    input logic ar,
    input logic d,
    output logic q
);

always @(posedge clk or posedge ar) begin
    if (ar)
        q <= 1'b0;  // Reset output to 0
    else
        q <= d;     // Latch input data
end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly