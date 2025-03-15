module TopModule(
    input logic mode,     // Mode: 1 for heating, 0 for cooling
    input logic too_cold, // Indicates if it's too cold
    input logic too_hot,  // Indicates if it's too hot
    input logic fan_on,   // Manual fan control
    output logic heater,  // Heater control output
    output logic aircon,  // Air conditioner control output
    output logic fan      // Fan control output
);

    always @(*) begin
        // Initialize outputs to default values
        heater = 1'b0;
        aircon = 1'b0;
        fan = 1'b0;

        // Determine heater and aircon based on mode and temperature
        if (mode) begin
            // Heating mode
            if (too_cold) begin
                heater = 1'b1;
            end
        end else begin
            // Cooling mode
            if (too_hot) begin
                aircon = 1'b1;
            end
        end

        // Determine fan state
        if (heater || aircon || fan_on) begin
            fan = 1'b1;
        end
    end

endmodule