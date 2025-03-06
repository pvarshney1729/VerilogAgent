```verilog
module TopModule (
    input logic clk,
    input logic reset,  // Added reset input
    input logic [7:0] d,
    output logic [7:0] q
);

always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 8'b00000000;
    end else begin
        q <= d;
    end
end

endmodule
```