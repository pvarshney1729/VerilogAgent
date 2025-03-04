module TopModule (
    input logic clk,
    input logic d,
    input logic rst_n,
    output logic q
);
    always @(posedge clk) begin
        if (rst_n)
            q <= 1'b0;
        else
            q <= d;
    end
endmodule