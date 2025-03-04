module TopModule(
    input logic ring,
    input logic vibrate_mode,
    output logic ringer,
    output logic motor
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