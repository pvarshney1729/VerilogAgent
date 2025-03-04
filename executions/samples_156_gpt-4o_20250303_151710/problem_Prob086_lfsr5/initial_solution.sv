```verilog
module TopModule (
    input logic clk,
    input logic reset,
    output logic [4:0] q
);

always_ff @(posedge clk) begin
    if (reset) begin
        q <= 5'b00001; // Reset state
    end else begin
        q <= {q[3:0], q[0] ^ q[2]}; // Shift and feedback
    end
end

endmodule
```