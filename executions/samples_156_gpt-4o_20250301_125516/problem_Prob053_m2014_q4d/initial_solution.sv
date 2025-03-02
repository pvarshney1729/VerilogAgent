```verilog
module TopModule (
    input logic clk,
    input logic in,
    output logic out
);

    logic xor_result;

    assign xor_result = in ^ out;

    always_ff @(posedge clk) begin
        out <= xor_result;
    end

endmodule
```