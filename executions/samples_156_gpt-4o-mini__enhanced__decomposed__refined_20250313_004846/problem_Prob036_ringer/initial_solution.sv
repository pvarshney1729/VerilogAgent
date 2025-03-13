[BEGIN]
module TopModule (
    input logic ring,          // 1-bit input: indicates an incoming call
    input logic vibrate_mode,  // 1-bit input: 1 indicates vibrate mode is enabled
    output logic ringer,       // 1-bit output: 1 activates the ringer
    output logic motor         // 1-bit output: 1 activates the vibration motor
);

always @(*) begin
    if (vibrate_mode) begin
        ringer = 1'b0;
        motor = 1'b1;
    end else if (ring) begin
        ringer = 1'b1;
        motor = 1'b0;
    end else begin
        ringer = 1'b0;
        motor = 1'b0;
    end
end

endmodule
[DONE]