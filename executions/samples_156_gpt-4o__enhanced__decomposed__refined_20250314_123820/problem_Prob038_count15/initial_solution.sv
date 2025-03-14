[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    output logic [3:0] q
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000;
        end else begin
            if (q == 4'b1111) begin
                q <= 4'b0000;
            end else begin
                q <= q + 4'b0001;
            end
        end
    end

endmodule
[DONE]