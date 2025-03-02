```verilog
module TopModule(
    input wire clk,
    input wire rst_n,
    input wire [7:0] in,
    output reg [7:0] pedge
);

    reg [7:0] prev_in;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pedge <= 8'b0;
            prev_in <= 8'b0;
        end else begin
            pedge <= (~prev_in & in);
            prev_in <= in;
        end
    end

endmodule
```