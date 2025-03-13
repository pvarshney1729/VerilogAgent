[BEGIN]
```verilog
module TopModule (
    input  logic       clk,         // Clock signal, positive-edge triggered
    input  logic       areset,      // Asynchronous reset, active high
    input  logic       train_valid, // Training valid signal, active high
    input  logic       train_taken, // Training taken signal, active high
    output logic [1:0] state        // 2-bit output representing the counter state
);

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b01; // Set to weakly not-taken on reset
    end else if (train_valid) begin
        if (train_taken && state < 2'b11) begin
            state <= state + 1; // Increment
        end else if (!train_taken && state > 2'b00) begin
            state <= state - 1; // Decrement
        end
    end
end

endmodule
```
[DONE]