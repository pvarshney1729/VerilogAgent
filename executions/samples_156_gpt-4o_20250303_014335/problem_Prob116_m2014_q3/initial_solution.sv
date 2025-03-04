module TopModule(
    input logic [3:0] x,
    output logic f
);

    // Simplified boolean expression derived from the Karnaugh map
    assign f = (!x[3] && !x[2] && x[1]) || (x[3] && !x[2]) || (x[3] && x[2] && !x[1]);

endmodule