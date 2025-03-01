```verilog
module TopModule(
    input logic clk,
    input logic rst,
    input logic [7:0] in,
    output logic [7:0] anyedge
);

    logic [7:0] prev_in;

    always @(posedge clk) begin
        if (rst) begin
            anyedge <= 8'b00000000;
            prev_in <= 8'b00000000;
        end else begin
            anyedge <= in ^ prev_in;
            prev_in <= in;
        end
    end

endmodule
```