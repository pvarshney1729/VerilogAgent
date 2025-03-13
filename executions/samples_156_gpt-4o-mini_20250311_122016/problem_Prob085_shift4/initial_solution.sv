```verilog
module TopModule (
    input logic clk,
    input logic areset,
    input logic load,
    input logic ena,
    input logic [3:0] data,
    output logic [3:0] q
);

always @(posedge clk) begin
    if (areset) begin
        q <= 4'b0000;  // Synchronous reset
    end else if (load) begin
        q <= data;     // Load data when load is asserted
    end else if (ena) begin
        q <= {1'b0, q[3:1]};  // Shift right when ena is asserted
    end
    // No change when neither load nor ena is asserted
end

endmodule
```