module TopModule (
    output logic out  // Output port, explicitly defined as a logic, 1-bit width
);

    // Drive the output 'out' to logic low (0) continuously
    assign out = 1'b0;

endmodule