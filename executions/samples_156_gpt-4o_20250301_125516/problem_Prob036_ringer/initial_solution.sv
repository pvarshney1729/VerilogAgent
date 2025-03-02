module TopModule (
    input logic ring,          // Input: Indicates an incoming call
    input logic vibrate_mode,  // Input: Indicates whether the phone is in vibrate mode
    output logic ringer,       // Output: Control signal for the phone's ringer
    output logic motor         // Output: Control signal for the phone's vibration motor
);

    always @(*) begin
        if (ring) begin
            if (vibrate_mode) begin
                motor = 1'b1;
                ringer = 1'b0;
            end else begin
                motor = 1'b0;
                ringer = 1'b1;
            end
        end else begin
            motor = 1'b0;
            ringer = 1'b0;
        end
    end

endmodule