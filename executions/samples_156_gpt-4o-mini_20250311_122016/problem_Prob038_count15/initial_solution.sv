[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    output logic [3:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000;
        end else begin
            q <= (q == 4'b1111) ? 4'b0000 : q + 1'b1;
        end
    end

endmodule
[DONE]