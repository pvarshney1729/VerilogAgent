module TopModule (
    input logic clk,
    input logic reset,
    output logic [9:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 10'b0;
        end else if (q < 10'd999) begin
            q <= q + 1;
        end else begin
            q <= 10'b0;
        end
    end

endmodule