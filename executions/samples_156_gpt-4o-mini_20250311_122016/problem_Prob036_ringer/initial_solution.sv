module TopModule (
    input logic ring,
    input logic vibrate_mode,
    output logic ringer,
    output logic motor
);

    // Assign the outputs based on the input conditions
    assign motor = vibrate_mode ? 1'b1 : 1'b0;
    assign ringer = (~vibrate_mode) & ring;

endmodule