module TopModule (
    input logic a,
    input logic b,
    input logic c,
    output logic y
);

    logic mux_in1, mux_in2, mux_in3, mux_in4;

    // K-map logic implementation for mux_in assignments
    assign mux_in1 = a & b;          // Example logic for mux_in1
    assign mux_in2 = a & ~b & c;     // Example logic for mux_in2
    assign mux_in3 = ~a & b & c;     // Example logic for mux_in3
    assign mux_in4 = a & b & c;       // Example logic for mux_in4

    // Final output logic based on mux_in assignments
    assign y = mux_in1 | mux_in2 | mux_in3 | mux_in4;

endmodule