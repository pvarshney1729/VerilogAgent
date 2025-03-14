```verilog
module TopModule (
    input logic mode,         // 1-bit input: mode of operation (1 = heating, 0 = cooling)
    input logic too_cold,    // 1-bit input: indicates if the temperature is too cold (1 = true)
    input logic too_hot,      // 1-bit input: indicates if the temperature is too hot (1 = true)
    input logic fan_on,       // 1-bit input: user request to turn on the fan (1 = true)
    output logic heater,       // 1-bit output: heater control signal (1 = on)
    output logic aircon,       // 1-bit output: air conditioner control signal (1 = on)
    output logic fan           // 1-bit output: fan control signal (1 = on)
);

    always @(*) begin
        // Default states
        heater = 1'b0;
        aircon = 1'b0;
        fan = 1'b0;

        if (mode) begin // Heating mode
            if (too_cold) begin
                heater = 1'b1;
            end
            // Aircon is always off in heating mode
            fan = heater | fan_on; // Fan on if heater is on or fan_on is requested
        end else begin // Cooling mode
            if (too_hot) begin
                aircon = 1'b1;
            end
            // Heater is always off in cooling mode
            fan = aircon | fan_on; // Fan on if aircon is on or fan_on is requested
        end
    end

endmodule
```