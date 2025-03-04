module TopModule (
    input wire clk,
    input wire reset,
    input wire shift_ena,
    input wire count_ena,
    input wire data,
    output reg [3:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000;
        end else if (shift_ena && !count_ena) begin
            q <= {data, q[3:1]};
        end else if (count_ena && !shift_ena) begin
            q <= q - 1'b1;
        end
    end

endmodule