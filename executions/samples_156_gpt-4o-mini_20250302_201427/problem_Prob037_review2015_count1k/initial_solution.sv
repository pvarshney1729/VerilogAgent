module TopModule (
    input logic clk,
    input logic reset,
    output logic [9:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 10'b0000000000;
        end else if (q == 10'd999) begin
            q <= 10'b0000000000;
        end else begin
            q <= q + 10'b0000000001;
        end
    end

endmodule