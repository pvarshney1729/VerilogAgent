```verilog
module TopModule (
    input logic clk,                    // Clock input, active on rising edge
    input logic rst_n,                  // Asynchronous reset, active low
    input logic [7:0] in,               // 8-bit unsigned input signal
    output logic [7:0] anyedge          // 8-bit unsigned output signal
);

logic [7:0] prev_in;  // Register to hold the previous state of `in`

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        anyedge <= 8'b0;
        prev_in <= 8'b0;
    end else begin
        anyedge <= in ^ prev_in;  // XOR to detect changes
        prev_in <= in;            // Update previous state
    end
end

endmodule
```