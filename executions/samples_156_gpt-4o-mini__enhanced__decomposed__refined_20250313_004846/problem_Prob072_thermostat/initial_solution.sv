[BEGIN]
module TopModule (
    input logic mode,        // 1-bit input: 1 for heating mode, 0 for cooling mode
    input logic too_cold,    // 1-bit input: 1 indicates too cold
    input logic too_hot,     // 1-bit input: 1 indicates too hot
    input logic fan_on,      // 1-bit input: 1 indicates user request to turn on fan
    output logic heater,      // 1-bit output: 1 to turn on the heater
    output logic aircon,      // 1-bit output: 1 to turn on the air conditioner
    output logic fan          // 1-bit output: 1 to turn on the fan
);

always @(*) begin
    // Default outputs
    heater = 1'b0;
    aircon = 1'b0;
    fan = 1'b0;

    if (mode) begin // Heating mode
        if (too_cold) heater = 1'b1;
    end else begin // Cooling mode
        if (too_hot) aircon = 1'b1;
    end

    // Fan control logic
    if (heater || aircon || fan_on) fan = 1'b1;
end

endmodule
[DONE]