[BEGIN]
```verilog
module TopModule (
    input logic clk,      
    input logic in,       
    output logic out       
);

    always_ff @(posedge clk) begin
        out <= in ^ out; // D flip-flop with XOR input
    end

    initial begin
        out = 1'b0; // Initialize out to 0
    end

endmodule
```
[DONE]