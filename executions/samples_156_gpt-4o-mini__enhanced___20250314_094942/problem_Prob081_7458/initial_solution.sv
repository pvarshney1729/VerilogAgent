module TopModule (
    input  logic p1a,
    input  logic p1b,
    input  logic p1c,
    input  logic p1d,
    input  logic p1e,
    input  logic p1f,
    input  logic p2a,
    input  logic p2b,
    input  logic p2c,
    input  logic p2d,
    output logic p1y,
    output logic p2y
);

    logic and1; // output of the first 3-input AND gate
    logic and2; // output of the second 3-input AND gate
    logic and3; // output of the first 2-input AND gate
    logic and4; // output of the second 2-input AND gate

    assign and1 = p1a & p1b & p1c;
    assign and2 = p1d & p1e & p1f;
    assign p1y = and1 | and2;

    assign and3 = p2a & p2b;
    assign and4 = p2c & p2d;
    assign p2y = and3 | and4;

endmodule