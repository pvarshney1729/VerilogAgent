module TopModule (
    input logic mode,       // Mode selection: 1 for heating, 0 for cooling
    input logic too_cold,   // Signal indicating if it's too cold
    input logic too_hot,    // Signal indicating if it's too hot
    input logic fan_on,     // User request to turn the fan on
    output logic heater,    // Control signal to turn the heater on
    output logic aircon,    // Control signal to turn the air conditioner on
    output logic fan        // Control signal to turn the fan on
);

    always @(*) begin
        // Default outputs
        heater = 1'b0;
        aircon = 1'b0;
        fan = 1'b0;

        if (mode) begin
            // Heating mode
            if (too_cold) begin
                heater = 1'b1;
            end
            fan = heater | fan_on;
        end else begin
            // Cooling mode
            if (too_hot) begin
                aircon = 1'b1;
            end
            fan = aircon | fan_on;
        end
    end

endmodule