```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic [7:0] pedge
);

    logic [7:0] prev_in;

    always_ff @(posedge clk) begin
        if (reset) begin
            pedge <= 8'b00000000;
            prev_in <= 8'b00000000;
        end else begin
            pedge <= in & ~prev_in;
            prev_in <= in;
        end
    end

endmodule
```