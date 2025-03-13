[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] d,
    output logic [7:0] q
);
    logic [7:0] q_next;

    always @(*) begin
        if (reset) begin
            q_next = 8'h34; // Set to 0x34 on reset
        end else begin
            q_next = d; // Assign input d to q_next
        end
    end

    always @(negedge clk) begin
        if (reset) begin
            q <= 8'h34; // Set to 0x34 on reset
        end else begin
            q <= q_next; // Update q on negative edge of clk
        end
    end
endmodule
```
[DONE]