```verilog
module TopModule(
    input logic clk,        // Clock signal, active on positive edge
    input logic areset,     // Asynchronous reset, active high
    input logic load,       // Load signal, active high
    input logic ena,        // Enable signal, active high
    input logic [3:0] data, // 4-bit input data for loading
    output logic [3:0] q    // 4-bit shift register output
);

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 4'b0000; // Asynchronous reset
        end else if (load) begin
            q <= data;    // Load data
        end else if (ena) begin
            q <= {1'b0, q[3:1]}; // Shift right
        end
    end

endmodule
```