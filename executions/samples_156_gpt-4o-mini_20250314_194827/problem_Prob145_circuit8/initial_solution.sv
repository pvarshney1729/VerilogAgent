module TopModule (
    input logic clk,
    input logic rst,
    input logic a,
    output logic p,
    output logic q
);

    always @(posedge clk) begin
        if (rst) begin
            p <= 1'b0;
        end else begin
            p <= a;
        end
    end

    always @(posedge clk) begin
        q <= p;
    end

endmodule