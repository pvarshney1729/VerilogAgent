module TopModule (
    output logic zero  // 1-bit output port representing a LOW signal
);

assign zero = 1'b0;  // Continuously drive the output to a LOW state

endmodule