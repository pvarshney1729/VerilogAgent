module TopModule (
    input wire ring,           // 1-bit input: indicates incoming call
    input wire vibrate_mode,   // 1-bit input: indicates if phone is in vibrate mode
    output reg ringer,         // 1-bit output: controls ringer
    output reg motor           // 1-bit output: controls vibration motor
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