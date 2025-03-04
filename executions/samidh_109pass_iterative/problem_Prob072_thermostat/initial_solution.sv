module TopModule (
    input logic mode,       // 1-bit, unsigned; mode = 1 for heating, mode = 0 for cooling
    input logic too_cold,   // 1-bit, unsigned; indicates if it's too cold
    input logic too_hot,    // 1-bit, unsigned; indicates if it's too hot
    input logic fan_on,     // 1-bit, unsigned; user can manually activate the fan
    output logic heater,    // 1-bit, unsigned; activates the heater
    output logic aircon,    // 1-bit, unsigned; activates the air conditioner
    output logic fan        // 1-bit, unsigned; activates the fan
);

always @(*) begin
    if (mode) begin
        // Heating Mode
        heater = too_cold;
        aircon = 1'b0;
    end else begin
        // Cooling Mode
        aircon = too_hot;
        heater = 1'b0;
    end
    fan = (heater || aircon || fan_on);
end

endmodule