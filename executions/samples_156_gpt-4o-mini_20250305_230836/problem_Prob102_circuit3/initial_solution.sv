module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic q
);
    assign q = (b & d) | (c & (b | a));
endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly