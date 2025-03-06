```verilog
[BEGIN]
module TopModule (
    input logic clk,
    input logic load,
    input logic [1:0] ena,
    input logic [99:0] data,
    output logic [99:0] q
);

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        case (ena)
            2'b01: begin // Rotate right
                q <= {q[0], q[99:1]};
            end
            2'b10: begin // Rotate left
                q <= {q[98:0], q[99]};
            end
            default: begin // No rotation
                q <= q;
            end
        endcase
    end
end

endmodule
[DONE]
```