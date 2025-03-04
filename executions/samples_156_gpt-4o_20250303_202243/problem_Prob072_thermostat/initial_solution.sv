module TopModule (
    input logic mode,        // Mode selector (1 for heating, 0 for cooling)
    input logic too_cold,    // Asserted when the temperature is too cold
    input logic too_hot,     // Asserted when the temperature is too hot
    input logic fan_on,      // User request to turn on the fan
    output logic heater,     // Controls the heater
    output logic aircon,     // Controls the air conditioner
    output logic fan         // Controls the blower fan
);

    always @(*) begin
        // Default all outputs to 0
        heater = 1'b0;
        aircon = 1'b0;
        fan = 1'b0;

        if (mode) begin
            // Heating Mode
            if (too_cold) begin
                heater = 1'b1;
            end
        end else begin
            // Cooling Mode
            if (too_hot) begin
                aircon = 1'b1;
            end
        end

        // Fan Control
        if (heater || aircon || fan_on) begin
            fan = 1'b1;
        end
    end

endmodule