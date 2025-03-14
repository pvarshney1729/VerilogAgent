```verilog
[BEGIN]
module TopModule (
    input logic clk,
    input logic load,
    input logic rst,
    input logic [1:0] ena,
    input logic [99:0] data,
    output logic [99:0] q
);

always @(posedge clk) begin
    if (rst) begin
        q <= 100'b0; // Synchronous reset to 100'b0
    end else if (load) begin
        q <= data; // Load data into q
    end else begin
        case (ena)
            2'b01: q <= {q[0], q[99:1]}; // Rotate right
            2'b10: q <= {q[98:0], q[99]}; // Rotate left
            default: q <= q; // No rotation
        endcase
    end
end

endmodule
[DONE]
```