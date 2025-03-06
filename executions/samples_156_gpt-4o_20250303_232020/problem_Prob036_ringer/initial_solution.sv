module TopModule (
    input wire ring,          // Incoming call signal, 1-bit input
    input wire vibrate_mode,  // Vibrate mode control, 1-bit input
    output reg ringer,        // Ringer control, 1-bit output
    output reg motor          // Motor control, 1-bit output
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