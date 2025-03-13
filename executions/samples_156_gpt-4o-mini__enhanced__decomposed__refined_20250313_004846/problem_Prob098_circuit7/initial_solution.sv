[DONE]
```verilog
module TopModule (
    input logic clk,
    input logic a,
    output logic q
);

initial begin
    q = 1'b0; // Assume initial state of q is 0
end

always @(posedge clk) begin
    if (a && !q) begin
        q <= 1'b1; // Set q to 1 when a transitions from 0 to 1
    end else if (a && q) begin
        q <= 1'b0; // Reset q to 0 when a is stable at 1
    end
end

endmodule
```