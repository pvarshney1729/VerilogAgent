module TopModule (
    input clk,
    input [7:0] in,
    input rst,
    output reg [7:0] pedge
);

    reg [7:0] prev_in;

    always @(posedge clk) begin
        if (rst) begin
            pedge <= 8'b00000000;
            prev_in <= 8'b00000000;
        end else begin
            pedge <= (in & ~prev_in);
            prev_in <= in;
        end
    end

endmodule