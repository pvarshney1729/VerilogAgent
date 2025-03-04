```verilog
module TopModule (
    input wire clk,             // Clock input
    input wire areset,          // Asynchronous reset, active high
    input wire load,            // Load signal, active high
    input wire ena,             // Enable signal, active high
    input wire [3:0] data,      // Data input (4 bits, unsigned)
    output reg [3:0] q          // Shift register output (4 bits, unsigned)
);

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 4'b0000;
        end else if (load) begin
            q <= data;
        end else if (ena) begin
            q <= {1'b0, q[3:1]};
        end
    end

endmodule
```