module TopModule (
    input logic clk,
    input logic d,
    output logic q
);
    logic d1, d2;

    always @(posedge clk) begin
        d1 <= d;
    end

    always @(negedge clk) begin
        d2 <= d;
    end

    assign q = d1 | d2;

endmodule