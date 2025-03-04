module TopModule (
    input logic clk,
    input logic rst,
    input logic [7:0] in,
    output logic [7:0] pedge
);

    logic [7:0] in_prev;

    always @(posedge clk) begin
        if (rst) begin
            pedge <= 8'b0;
            in_prev <= 8'b0;
        end else begin
            pedge <= ~in_prev & in;
            in_prev <= in;
        end
    end
endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly