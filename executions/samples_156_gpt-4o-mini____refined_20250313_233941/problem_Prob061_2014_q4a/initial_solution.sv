[DONE]
```verilog
module TopModule (
    input  logic clk,
    input  logic w,
    input  logic R,
    input  logic E,
    input  logic L,
    output logic Q
);

    always @(posedge clk) begin
        if (R) begin
            Q <= 1'b0; // Synchronous reset to zero
        end else if (L) begin
            Q <= 1'b1; // Load value when L is asserted
        end else if (E) begin
            Q <= w; // Shift value when E is asserted
        end
    end

endmodule
```