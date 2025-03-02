module TopModule (
    input logic mode,
    input logic too_cold,
    input logic too_hot,
    input logic fan_on,
    output logic heater,
    output logic aircon,
    output logic fan
);

always @(*) begin
    // Default states
    heater = 1'b0;
    aircon = 1'b0;
    fan = 1'b0;

    // Heater Control
    if (mode) begin // Heating mode
        heater = too_cold;
        aircon = 1'b0;
    end else begin // Cooling mode
        aircon = too_hot;
        heater = 1'b0;
    end

    // Fan Control
    if (heater || aircon || fan_on) begin
        fan = 1'b1;
    end else begin
        fan = 1'b0;
    end
end

endmodule