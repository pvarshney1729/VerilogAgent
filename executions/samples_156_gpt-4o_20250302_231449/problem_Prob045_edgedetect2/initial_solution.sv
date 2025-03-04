```verilog
module TopModule (
    input logic clk,
    input logic [7:0] in,
    input logic reset,
    output logic [7:0] anyedge
);

    logic [7:0] prev_in;

    always_ff @(posedge clk) begin
        if (reset) begin
            anyedge <= 8'b00000000;
            prev_in <= 8'b00000000;
        end else begin
            anyedge <= in ^ prev_in; // XOR operation to detect any edge
            prev_in <= in;
        end
    end

endmodule
```