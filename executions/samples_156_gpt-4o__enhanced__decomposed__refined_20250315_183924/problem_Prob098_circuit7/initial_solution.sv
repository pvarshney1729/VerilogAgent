[BEGIN]
module TopModule (
    input logic clk,
    input logic a,
    output logic q
);

    always_ff @(posedge clk) begin
        if (a) begin
            q <= ~q; // Toggle q if a is high
        end else begin
            q <= q; // Hold q if a is low
        end
    end

    initial begin
        q = 1'b0; // Initialize q to 0
    end

endmodule
[DONE]