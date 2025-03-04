module TopModule (
    input logic a,
    input logic b,
    input logic c,
    output logic out
);

    // Combinational logic derived from the Karnaugh map
    assign out = (a & (b | c)) | (~a & b & c);

endmodule