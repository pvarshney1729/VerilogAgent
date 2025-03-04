```verilog
module TopModule (
    input logic clk,
    input logic rst,
    input logic [7:0] in,
    output logic [7:0] anyedge
);

    logic [7:0] prev_state;

    always @(posedge clk) begin
        if (rst) begin
            anyedge <= 8'b00000000;
            prev_state <= 8'b00000000;
        end else begin
            anyedge <= (in ^ prev_state);
            prev_state <= in;
        end
    end

endmodule
```