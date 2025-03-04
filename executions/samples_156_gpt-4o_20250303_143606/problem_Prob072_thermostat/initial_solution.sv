```verilog
module TopModule (
    input wire heat_mode,    // 1 bit, indicates heating mode when high
    input wire too_cold,     // 1 bit, high if temperature is below desired in heating mode
    input wire too_hot,      // 1 bit, high if temperature is above desired in cooling mode
    input wire fan_on,       // 1 bit, user-requested fan activation
    output reg heater,       // 1 bit, controls the heater
    output reg aircon,       // 1 bit, controls the air conditioner
    output reg fan           // 1 bit, controls the blower fan
);

always @(*) begin
    if (heat_mode) begin
        // Heating mode
        heater = too_cold;
        aircon = 1'b0;
        fan = too_cold || fan_on;
    end else begin
        // Cooling mode
        aircon = too_hot;
        heater = 1'b0;
        fan = too_hot || fan_on;
    end
end

endmodule
```