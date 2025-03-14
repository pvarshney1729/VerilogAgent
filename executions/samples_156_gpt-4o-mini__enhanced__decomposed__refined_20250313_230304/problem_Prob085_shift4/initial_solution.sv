[BEGIN]
```verilog
module TopModule (
    input logic clk,          // Clock input (1 bit)
    input logic areset,      // Asynchronous active-high reset (1 bit)
    input logic load,        // Synchronous active-high load signal (1 bit)
    input logic ena,         // Synchronous active-high enable signal (1 bit)
    input logic [3:0] data,  // 4-bit data input for loading
    output logic [3:0] q     // 4-bit shift register output
);

always @(posedge clk) begin
    if (areset) begin
        q <= 4'b0000;  // Asynchronous reset to zero
    end else if (load) begin
        q <= data;     // Load data into shift register
    end else if (ena) begin
        q <= {1'b0, q[3:1]}; // Right shift operation, q[3] becomes 0
    end
    // If neither load nor ena are asserted, q retains its previous value
end

endmodule
```
[DONE]