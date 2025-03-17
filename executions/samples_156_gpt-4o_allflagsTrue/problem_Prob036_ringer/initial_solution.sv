module TopModule(
    input logic ring,
    input logic vibrate_mode,
    output logic ringer,
    output logic motor
);

    // Combinational logic to control ringer and motor
    assign ringer = ring & ~vibrate_mode; // Activate ringer if ring is high and vibrate_mode is low
    assign motor = ring & vibrate_mode;   // Activate motor if both ring and vibrate_mode are high

endmodule