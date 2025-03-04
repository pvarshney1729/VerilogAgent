module TopModule (
    input logic clk,
    input logic reset,
    output logic [9:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 10'b0;
        end else begin
            if (q == 10'd999) begin
                q <= 10'b0;
            end else begin
                q <= q + 10'b1;
            end
        end
    end

endmodule