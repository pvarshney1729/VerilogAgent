module TopModule (
    input logic clk,
    input logic reset_n,
    input logic a,
    output logic q
);

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            q <= 1'b0;
        end else begin
            if (a == 1'b0) begin
                q <= 1'b1;
            end else begin
                q <= 1'b0;
            end
        end
    end

endmodule