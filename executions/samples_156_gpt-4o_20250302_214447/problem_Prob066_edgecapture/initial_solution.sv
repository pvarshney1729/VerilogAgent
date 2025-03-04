```verilog
module TopModule(
    input wire clk,
    input wire reset,
    input wire [31:0] in,
    output reg [31:0] out
);

    reg [31:0] prev_in;

    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0;
            prev_in <= 32'b0;
        end else begin
            out <= out | (prev_in & ~in);
            prev_in <= in;
        end
    end

endmodule
```