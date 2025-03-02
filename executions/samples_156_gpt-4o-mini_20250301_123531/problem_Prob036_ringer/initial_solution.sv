module TopModule (
    input logic ring,          // 1-bit input signal indicating an incoming call
    input logic vibrate_mode,  // 1-bit input signal indicating vibrate mode is active
    output logic ringer,       // 1-bit output signal to control the ringer
    output logic motor         // 1-bit output signal to control the vibration motor
);

    always @(*) begin
        if (ring) begin
            if (vibrate_mode) begin
                ringer = 1'b0;
                motor = 1'b1;
            end else begin
                ringer = 1'b1;
                motor = 1'b0;
            end
        end else begin
            ringer = 1'b0;
            motor = 1'b0;
        end
    end

endmodule