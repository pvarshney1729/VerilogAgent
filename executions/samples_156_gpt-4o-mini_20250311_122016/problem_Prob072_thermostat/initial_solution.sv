[BEGIN]
module TopModule (
    input logic mode,          // Thermostat mode: 1 for heating, 0 for cooling
    input logic too_cold,      // Signal indicating the temperature is too low
    input logic too_hot,       // Signal indicating the temperature is too high
    input logic fan_on,        // User request to turn on the fan
    output logic heater,        // Output to control the heater
    output logic aircon,        // Output to control the air conditioning
    output logic fan            // Output to control the circulation fan
);

always @(*) begin
    // Default outputs
    heater = 1'b0;
    aircon = 1'b0;
    fan = 1'b0;
    
    // Heating mode
    if (mode == 1'b1) begin
        if (too_cold == 1'b1) begin
            heater = 1'b1;
        end
    end
    // Cooling mode
    else begin
        if (too_hot == 1'b1) begin
            aircon = 1'b1;
        end
    end

    // Fan control
    fan = heater || aircon || fan_on;
end

endmodule
[DONE]