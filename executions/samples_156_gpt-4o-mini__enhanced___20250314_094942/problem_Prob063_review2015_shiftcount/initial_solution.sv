module TopModule (
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    input reset,
    output reg [3:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000;
        end else if (shift_ena) begin
            q <= {q[2:0], data};
        end else if (count_ena) begin
            if (q > 4'b0000) begin
                q <= q - 1;
            end
        end
    end

endmodule