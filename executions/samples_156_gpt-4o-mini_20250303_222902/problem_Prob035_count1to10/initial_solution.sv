module TopModule (
    input logic clk,
    input logic reset,
    output logic [3:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0001;
        end else begin
            if (q == 4'b1010) begin
                q <= 4'b0001;
            end else begin
                q <= q + 1;
            end
        end
    end

    initial begin
        q = 4'b0001;
    end

endmodule