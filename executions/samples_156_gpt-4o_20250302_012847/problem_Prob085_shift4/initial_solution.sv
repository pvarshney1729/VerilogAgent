```verilog
module shift_register (
    input logic clk,
    input logic areset,  // Asynchronous reset
    input logic ena,
    input logic load,
    input logic [3:0] data,
    output logic [3:0] q
);

    always_ff @(posedge clk) begin
        if (areset) begin
            q <= 4'b0000;  // Initialize all flip-flops to zero
        end else if (load) begin
            q <= data;  // Load data when load is high
        end else if (ena) begin
            q <= {1'b0, q[3:1]};  // Right shift operation
        end
    end

endmodule
```