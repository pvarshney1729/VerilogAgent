module TopModule (
    input logic clk,
    input logic d,
    output logic q
);

    logic intermediate;

    always @(posedge clk) begin
        intermediate <= d;
    end

    always @(negedge clk) begin
        q <= intermediate;
    end

    initial begin
        q = 1'b0;
    end

endmodule