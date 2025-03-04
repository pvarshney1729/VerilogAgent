module TopModule (
    input logic clk,
    input logic a,
    input logic reset,
    output logic [2:0] q
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 3'b000;
        end else if (a == 1'b0) begin
            q <= q + 1'b1;
        end
    end

endmodule