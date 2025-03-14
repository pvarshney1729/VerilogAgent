```verilog
module TopModule (
    input logic ring,          // 1-bit input: Indicates an incoming call
    input logic vibrate_mode,  // 1-bit input: Indicates if the phone is in vibrate mode
    output logic ringer,       // 1-bit output: Controls the phone ringer
    output logic motor         // 1-bit output: Controls the vibration motor
);

    always @(*) begin
        if (ring) begin
            ringer = !vibrate_mode;
            motor = vibrate_mode;
        end else begin
            ringer = 1'b0;
            motor = 1'b0;
        end
    end

endmodule
```