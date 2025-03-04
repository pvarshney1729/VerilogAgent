```verilog
module TopModule(
    input wire clk,
    input wire rst,
    input wire [7:0] in,
    output reg [7:0] pedge
);

    reg [7:0] prev_in;

    always @(posedge clk) begin
        if (rst) begin
            pedge <= 8'b00000000;
            prev_in <= 8'b00000000;
        end else begin
            pedge <= ~prev_in & in; // Detect 0 to 1 transition
            prev_in <= in;
        end
    end

endmodule
```