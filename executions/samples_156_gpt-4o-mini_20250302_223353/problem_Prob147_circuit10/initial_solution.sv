module TopModule (
    input logic clk,
    input logic a,
    input logic b,
    output logic q,
    output logic state
);

    always @(*) begin
        q = (a & ~b) ^ state;
    end

    always @(posedge clk) begin
        state <= (b & ~a) ^ q;
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly