```
[BEGIN]
module TopModule (
    input logic clk,
    input logic [7:0] in,
    output logic [7:0] pedge
);

    logic [7:0] prev_in;

    always @(posedge clk) begin
        prev_in <= in; // Store the current state of the input
        pedge <= (~prev_in & in); // Detect positive edges
    end

endmodule
[DONE]
```