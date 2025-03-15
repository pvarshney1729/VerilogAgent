module TopModule (
    input logic [99:0] a,
    input logic [99:0] b,
    input logic sel,
    output logic [99:0] out
);

    assign out = (sel == 1'b0) ? a : b;

endmodule