module TopModule (
    input wire ring,          // 1-bit input: Indicates an incoming call
    input wire vibrate_mode,  // 1-bit input: Indicates if the phone is in vibrate mode
    output reg ringer,        // 1-bit output: Controls the phone's ringer
    output reg motor          // 1-bit output: Controls the phone's vibration motor
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