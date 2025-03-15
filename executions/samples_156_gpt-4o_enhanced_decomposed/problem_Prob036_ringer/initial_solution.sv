module TopModule(
    input logic ring,
    input logic vibrate_mode,
    output logic ringer,
    output logic motor
);

    always @(*) begin
        if (ring) begin
            if (vibrate_mode) begin
                motor = 1;
                ringer = 0;
            end else begin
                ringer = 1;
                motor = 0;
            end
        end else begin
            ringer = 0;
            motor = 0;
        end
    end

endmodule