module TopModule (
    input logic mode,      // 1-bit, unsigned: 1 for heating mode, 0 for cooling mode
    input logic too_cold,  // 1-bit, unsigned: 1 when temperature is below threshold
    input logic too_hot,   // 1-bit, unsigned: 1 when temperature is above threshold
    input logic fan_on,    // 1-bit, unsigned: 1 to manually turn on the fan
    output logic heater,   // 1-bit, unsigned: 1 to turn on the heater
    output logic aircon,   // 1-bit, unsigned: 1 to turn on the air conditioner
    output logic fan       // 1-bit, unsigned: 1 to turn on the fan
);

    always @(*) begin
        // Default all outputs to 0
        heater = 1'b0;
        aircon = 1'b0;
        fan = 1'b0;

        if (mode) begin
            // Heating mode
            if (too_cold) begin
                heater = 1'b1;
                fan = 1'b1;
            end
        end else begin
            // Cooling mode
            if (too_hot) begin
                aircon = 1'b1;
                fan = 1'b1;
            end
        end

        // Manual fan control
        if (fan_on) begin
            fan = 1'b1;
        end
    end

endmodule