```verilog
module TopModule (
    input wire clk,          // Clock signal, active on positive edge
    input wire areset,       // Asynchronous reset signal, active high
    input wire [7:0] d,      // 8-bit input data bus, unsigned
    output reg [7:0] q       // 8-bit output data bus, unsigned
);

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 8'b00000000;
        end else begin
            q <= d;
        end
    end

endmodule
```