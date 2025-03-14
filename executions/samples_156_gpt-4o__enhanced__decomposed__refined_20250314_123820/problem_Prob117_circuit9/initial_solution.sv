[BEGIN]
module TopModule (
    input logic clk,
    input logic a,
    output logic [2:0] q
);

    always_ff @(posedge clk) begin
        if (a) begin
            q <= 3'b100;
        end else begin
            if (q == 3'b111)
                q <= 3'b000;
            else
                q <= q + 1;
        end
    end

endmodule
[DONE]