module TopModule (
    input  logic mode,
    input  logic too_cold,
    input  logic too_hot,
    input  logic fan_on,
    output logic heater,
    output logic aircon,
    output logic fan
);

    always @(*) begin
        // Default output values
        heater = 1'b0;
        aircon = 1'b0;
        fan = 1'b0;

        // Control logic for heater and air conditioner based on mode
        if (mode) begin // Heating mode
            if (too_cold) begin
                heater = 1'b1; // Turn on heater
            end
            // Air conditioner is off in heating mode
        end else begin // Cooling mode
            if (too_hot) begin
                aircon = 1'b1; // Turn on air conditioner
            end
            // Heater is off in cooling mode
        end

        // Fan control: on if fan_on is 1 or if heater or aircon is on
        fan = fan_on || heater || aircon;
    end

endmodule