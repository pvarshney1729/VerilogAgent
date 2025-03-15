module TopModule (
    output logic one // 1-bit output that is always high
);

    // Continuously drive the output to logic high (1)
    assign one = 1'b1;

endmodule