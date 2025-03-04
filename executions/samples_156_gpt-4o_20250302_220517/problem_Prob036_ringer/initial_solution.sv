module TopModule (
    input logic ring,          // Incoming call signal
    input logic vibrate_mode,  // Mode selection for vibrate
    output logic ringer,       // Output to control the ringer
    output logic motor         // Output to control the vibration motor
);

always @(*) begin
    if (ring) begin
        if (vibrate_mode) begin
            motor = 1'b1;
            ringer = 1'b0;
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