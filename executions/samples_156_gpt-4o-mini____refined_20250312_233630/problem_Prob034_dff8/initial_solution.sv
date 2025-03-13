[BEGIN]
module TopModule (
    input logic clk,
    input logic [7:0] d,
    output logic [7:0] q
);
    always @(posedge clk) begin
        q <= d;  // D flip-flops capturing the input d on the rising edge of clk
    end
endmodule
[DONE]