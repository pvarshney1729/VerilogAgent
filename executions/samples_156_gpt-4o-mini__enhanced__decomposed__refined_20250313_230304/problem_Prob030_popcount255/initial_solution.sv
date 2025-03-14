```verilog
module TopModule (
    input  logic [254:0] in,  // 255-bit input vector
    input  logic clk,          // Clock for synchronous behavior
    input  logic rst_n,        // Asynchronous active-low reset
    output logic [7:0] out     // 8-bit output for population count
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        out <= 8'b0; // Initialize output to zero on reset
    end else begin
        integer i;
        logic [7:0] count; // Temporary variable for counting
        
        count = 8'b0; // Initialize count to zero
        
        for (i = 0; i < 255; i = i + 1) begin
            count = count + in[i]; // Add the value of each bit to count
        end
        
        out <= count; // Assign final count to output
    end
end

endmodule
```