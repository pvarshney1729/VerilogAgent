module TopModule(
    input logic in_signal,
    output logic out_signal
);

    // Combinational logic for NOT gate
    assign out_signal = ~in_signal;

endmodule