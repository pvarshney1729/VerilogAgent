module TopModule (
    input logic mode,       // 1-bit input: mode of operation (1 for heating, 0 for cooling)
    input logic too_cold,   // 1-bit input: signal indicating if it's too cold
    input logic too_hot,    // 1-bit input: signal indicating if it's too hot
    input logic fan_on,     // 1-bit input: user request to turn on the fan
    output logic heater,    // 1-bit output: controls the heater
    output logic aircon,    // 1-bit output: controls the air conditioner
    output logic fan        // 1-bit output: controls the blower fan
);

    always @(*) begin
        // Heating Mode
        if (mode) begin
            heater = too_cold;
            aircon = 1'b0;
        end
        // Cooling Mode
        else begin
            aircon = too_hot;
            heater = 1'b0;
        end

        // Fan Control
        fan = heater || aircon || fan_on;
    end

endmodule