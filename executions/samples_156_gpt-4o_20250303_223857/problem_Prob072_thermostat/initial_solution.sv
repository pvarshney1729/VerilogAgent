module TopModule(
    input logic mode,        // 1-bit, 0 for cooling mode, 1 for heating mode
    input logic too_cold,    // 1-bit, active high when temperature is too low
    input logic too_hot,     // 1-bit, active high when temperature is too high
    input logic fan_on,      // 1-bit, user request to turn the fan on
    output logic heater,     // 1-bit, active high to turn on heater
    output logic aircon,     // 1-bit, active high to turn on air conditioner
    output logic fan         // 1-bit, active high to turn on fan
);

    always @(*) begin
        // Default outputs
        heater = 1'b0;
        aircon = 1'b0;
        fan = 1'b0;

        // Mode selection logic
        if (mode) begin
            // Heating mode
            heater = too_cold;
            aircon = 1'b0;
        end else begin
            // Cooling mode
            aircon = too_hot;
            heater = 1'b0;
        end

        // Fan control logic
        fan = heater | aircon | fan_on;
    end

endmodule