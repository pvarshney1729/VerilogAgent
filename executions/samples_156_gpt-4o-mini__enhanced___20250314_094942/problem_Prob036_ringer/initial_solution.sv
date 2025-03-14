```verilog
module TopModule (
    input logic ring,               // Input signal indicating an incoming call (1 bit, unsigned)
    input logic vibrate_mode,       // Input signal indicating vibrate mode status (1 bit, unsigned)
    input logic reset,              // Asynchronous reset signal (1 bit, unsigned)
    output logic ringer,            // Output signal to activate ringer (1 bit, unsigned)
    output logic motor              // Output signal to activate vibration motor (1 bit, unsigned)
);

    always @(*) begin
        if (reset) begin
            ringer = 0;              // Set ringer to 0 on reset
            motor = 0;               // Set motor to 0 on reset
        end else begin
            if (ring) begin
                if (vibrate_mode) begin
                    motor = 1;        // Activate motor in vibrate mode
                    ringer = 0;      // Deactivate ringer
                end else begin
                    ringer = 1;      // Activate ringer
                    motor = 0;       // Deactivate motor
                end
            end else begin
                ringer = 0;          // Deactivate ringer if no ring
                motor = 0;           // Deactivate motor if no ring
            end
        end
    end

endmodule
```