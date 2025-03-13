```verilog
[BEGIN]
module TopModule(
    input logic clk,
    input logic [7:0] in,
    output logic [7:0] pedge
);

logic [7:0] prev_in;

always_ff @(posedge clk) begin
    pedge <= (in & ~prev_in); // Detect positive edges
    prev_in <= in;            // Update previous input
end

initial begin
    pedge = 8'b00000000; // Set initial state of pedge to 0
end

endmodule
[DONE]
```