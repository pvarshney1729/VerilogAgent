module TopModule (
    input logic clk,
    input logic r,
    input logic d,
    output logic q
);

    always @(posedge clk) begin
        if (r) begin
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end

endmodule