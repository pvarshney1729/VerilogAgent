[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] d,
    output logic [7:0] q
);

    always_ff @(negedge clk) begin
        if (reset == 1'b1) begin
            q <= 8'h34;
        end else begin
            q <= d;
        end
    end

endmodule
[DONE]