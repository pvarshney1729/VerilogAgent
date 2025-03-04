```verilog
module TopModule (
    input logic ring,          // Incoming call signal, active high
    input logic vibrate_mode,  // Vibrate mode control, active high
    output logic ringer,       // Ring control output, active high
    output logic motor         // Vibration motor control output, active high
);

    // Combinational logic to determine the state of ringer and motor
    assign ringer = ring && ~vibrate_mode;
    assign motor = ring && vibrate_mode;

endmodule
```