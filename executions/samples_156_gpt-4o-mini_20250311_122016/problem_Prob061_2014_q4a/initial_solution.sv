```
[BEGIN]
module TopModule (
    input logic clk,
    input logic w,
    input logic R,
    input logic E,
    input logic L,
    output logic Q
);

    always @(posedge clk) begin
        if (L) begin
            Q <= R; // Load R into Q
        end else if (E) begin
            Q <= w; // Shift w into Q
        end
        // If neither L nor E is high, Q retains its value
    end

    initial begin
        Q = 1'b0; // Initialize Q to 0
    end

endmodule
[DONE]
```