```verilog
module TopModule(
    input logic mode,       // 1-bit input; 1 for heating mode, 0 for cooling mode
    input logic too_cold,   // 1-bit input; 1 indicates temperature is below desired threshold
    input logic too_hot,    // 1-bit input; 1 indicates temperature is above desired threshold
    input logic fan_on,     // 1-bit input; user request to turn on the fan
    output logic heater,    // 1-bit output; 1 to turn on the heater
    output logic aircon,    // 1-bit output; 1 to turn on the air conditioner
    output logic fan        // 1-bit output; 1 to turn on the fan
);

    always @(*) begin
        // Default outputs
        heater = 1'b0;
        aircon = 1'b0;
        fan = 1'b0;

        // Mode Control
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

        // Fan Control
        if (heater || aircon || fan_on) begin
            fan = 1'b1;
        end
    end

endmodule
```