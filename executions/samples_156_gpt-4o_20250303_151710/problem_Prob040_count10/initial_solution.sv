module TopModule (
    input  logic clk,
    input  logic reset,
    output logic [3:0] q
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 4'd0;
        end else if (q == 4'd9) begin
            q <= 4'd0;
        end else begin
            q <= q + 4'd1;
        end
    end

endmodule