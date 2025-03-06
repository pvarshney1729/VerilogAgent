```verilog
module TopModule (
    input logic clk,
    input logic rst,
    input logic [7:0] in,
    output logic [7:0] pedge
);

    logic [7:0] prev_in;

    always_ff @(posedge clk) begin
        if (rst) begin
            pedge <= 8'b0;
            prev_in <= 8'b0;
        end else begin
            pedge <= (~prev_in) & in;
            prev_in <= in;
        end
    end

endmodule
```