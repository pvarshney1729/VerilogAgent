module TopModule (
    input  logic a,
    input  logic b,
    input  logic c,
    output logic w,
    output logic x,
    output logic y,
    output logic z
);

    // Connect input a to output w
    assign w = a;

    // Connect input b to outputs x and y
    assign x = b;
    assign y = b;

    // Connect input c to output z
    assign z = c;

endmodule