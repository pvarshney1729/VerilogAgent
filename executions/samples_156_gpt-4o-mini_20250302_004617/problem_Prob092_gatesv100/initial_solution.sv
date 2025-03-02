module TopModule (
    input logic a,
    input logic b,
    output logic out_both,
    output logic out_any,
    output logic out_different
);

    assign out_both = a & b;             // Both a and b are high
    assign out_any = a | b;              // Either a or b is high
    assign out_different = a ^ b;        // a and b are different

endmodule