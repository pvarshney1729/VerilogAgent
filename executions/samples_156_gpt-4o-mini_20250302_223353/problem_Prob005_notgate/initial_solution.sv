module TopModule (
    input logic input_signal,
    output logic output_signal
);

    assign output_signal = ~input_signal;

endmodule