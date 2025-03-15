module TopModule (
    input  logic ring,
    input  logic vibrate_mode,
    output logic ringer,
    output logic motor
);

    always @(*) begin
        // Default outputs
        ringer = 1'b0;
        motor = 1'b0;

        // Control logic based on inputs
        if (ring) begin
            if (vibrate_mode) begin
                motor = 1'b1; // Activate motor in vibrate mode
            end else begin
                ringer = 1'b1; // Activate ringer when not in vibrate mode
            end
        end
    end

endmodule