module TopModule (
    input logic in1,  // Single bit input, active-high logic level.
    input logic in2,  // Single bit input, active-high logic level.
    output logic out  // Single bit output, active-high logic level.
);

    // Combinational logic for 2-input NOR gate
    assign out = ~(in1 | in2);

endmodule