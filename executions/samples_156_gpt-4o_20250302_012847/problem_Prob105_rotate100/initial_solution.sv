```verilog
module rotate_capture (
    input logic clk,
    input logic reset,
    input logic load,
    input logic ena,
    input logic [99:0] data,
    output logic [99:0] q
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 100'b0;
        end else if (load) begin
            q <= data;
        end else if (ena) begin
            q <= {q[98:0], q[99]}; // Rotate left by 1 bit
        end
    end

endmodule
```