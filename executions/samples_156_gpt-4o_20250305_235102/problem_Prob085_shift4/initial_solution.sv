```
[BEGIN]
module TopModule (
    input logic clk,          // Clock signal, positive edge triggered
    input logic areset,       // Asynchronous reset, active high
    input logic load,         // Synchronous load control signal, active high
    input logic ena,          // Synchronous enable for shifting, active high
    input logic [3:0] data,   // 4-bit data input, unsigned
    output logic [3:0] q      // 4-bit shift register output, unsigned
);

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 4'b0000; // Asynchronous reset
        end else if (load) begin
            q <= data; // Load data
        end else if (ena) begin
            q <= {1'b0, q[3:1]}; // Shift operation
        end
    end

endmodule
[DONE]
```