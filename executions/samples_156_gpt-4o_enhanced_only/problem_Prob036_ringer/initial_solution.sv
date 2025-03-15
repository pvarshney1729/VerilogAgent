module TopModule(
    input logic ring,
    input logic vibrate_mode,
    output logic ringer,
    output logic motor
);

    always @(*) begin
        if (ring) begin
            if (vibrate_mode) begin
                // Vibrate mode is active, so turn on the motor
                motor = 1'b1;
                ringer = 1'b0;
            end else begin
                // Normal mode, so turn on the ringer
                motor = 1'b0;
                ringer = 1'b1;
            end
        end else begin
            // No incoming call, turn off both ringer and motor
            motor = 1'b0;
            ringer = 1'b0;
        end
    end

endmodule