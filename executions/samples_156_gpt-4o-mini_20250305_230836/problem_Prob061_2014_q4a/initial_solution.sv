```verilog
module TopModule (
    input logic clk,
    input logic w,
    input logic R,
    input logic E,
    input logic L,
    output logic Q
);

always @(posedge clk) begin
    if (L == 1'b1) begin
        Q <= R;
    end else if (E == 1'b1) begin
        Q <= w;
    end
    // If neither L nor E is asserted, Q retains its previous state
end

endmodule
```