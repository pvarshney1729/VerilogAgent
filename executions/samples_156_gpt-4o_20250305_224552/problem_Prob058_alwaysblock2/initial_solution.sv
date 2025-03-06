```verilog
module TopModule (
    input wire clk,
    input wire a,
    input wire b,
    output wire out_assign,
    output wire out_always_comb,
    output reg out_always_ff
);

// Combinational logic using assign statement
assign out_assign = a ^ b;

// Combinational logic using always block
always @(*) begin
    out_always_comb = a ^ b;
end

// Sequential logic using always block
always @(posedge clk) begin
    out_always_ff <= a ^ b;
end

endmodule
```