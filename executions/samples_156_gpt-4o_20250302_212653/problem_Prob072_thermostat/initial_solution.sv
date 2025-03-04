module TopModule (
    input logic mode,        // 1-bit: Mode of operation (1 for heating, 0 for cooling)
    input logic too_cold,    // 1-bit: Indicates if it is too cold (1 if true)
    input logic too_hot,     // 1-bit: Indicates if it is too hot (1 if true)
    input logic fan_on,      // 1-bit: User request to turn the fan on (1 if true)
    output logic heater,     // 1-bit: Control signal to turn the heater on/off
    output logic aircon,     // 1-bit: Control signal to turn the air conditioner on/off
    output logic fan         // 1-bit: Control signal to turn the fan on/off
);

    always @(*) begin
        // Initialize outputs
        heater = 1'b0;
        aircon = 1'b0;
        fan = 1'b0;

        // Determine heater and aircon states based on mode and temperature conditions
        if (mode) begin
            // Heating mode
            heater = too_cold;
            aircon = 1'b0;
        end else begin
            // Cooling mode
            aircon = too_hot;
            heater = 1'b0;
        end

        // Determine fan state
        fan = heater || aircon || fan_on;
    end

endmodule