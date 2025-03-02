module TopModule (
    input logic mode,       // 1-bit input: 1 for heating mode, 0 for cooling mode
    input logic too_cold,   // 1-bit input: 1 when temperature is below desired level
    input logic too_hot,    // 1-bit input: 1 when temperature is above desired level
    input logic fan_on,     // 1-bit input: 1 to manually turn on the fan
    output logic heater,    // 1-bit output: 1 to activate the heater
    output logic aircon,    // 1-bit output: 1 to activate the air conditioner
    output logic fan        // 1-bit output: 1 to activate the fan
);

    always @(*) begin
        // Default outputs
        heater = 1'b0;
        aircon = 1'b0;
        
        // Mode-based control
        if (mode) begin
            // Heating mode
            if (too_cold) begin
                heater = 1'b1;
            end
            aircon = 1'b0;
        end else begin
            // Cooling mode
            if (too_hot) begin
                aircon = 1'b1;
            end
            heater = 1'b0;
        end
        
        // Fan control
        fan = heater || aircon || fan_on;
    end

endmodule