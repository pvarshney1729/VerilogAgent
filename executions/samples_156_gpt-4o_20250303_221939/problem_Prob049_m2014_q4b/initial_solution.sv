```verilog
module TopModule (
    input logic i_clk,
    input logic i_ar,
    input logic i_d,
    output logic o_q
);

always @(posedge i_clk or posedge i_ar) begin
    if (i_ar) begin
        o_q <= 1'b0; // Reset state
    end else begin
        o_q <= i_d; // Capture the input data
    end
end

endmodule
```