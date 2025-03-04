module TopModule (
    input wire ring,          // 1-bit input for incoming call indicator
    input wire vibrate_mode,  // 1-bit input for vibrate mode status
    output reg ringer,        // 1-bit output to control ringer
    output reg motor          // 1-bit output to control vibration motor
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