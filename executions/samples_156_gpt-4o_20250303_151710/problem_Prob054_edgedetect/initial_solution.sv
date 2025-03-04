module TopModule(
    input wire clk,
    input wire [7:0] in,
    output reg [7:0] pedge
);

    reg [7:0] prev_in;

    always @(posedge clk) begin
        pedge <= in & ~prev_in;
        prev_in <= in;
    end

endmodule