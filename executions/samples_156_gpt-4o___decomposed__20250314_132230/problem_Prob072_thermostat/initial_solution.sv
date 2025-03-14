module TopModule(
    input logic mode,
    input logic too_cold,
    input logic too_hot,
    input logic fan_on,
    output logic heater,
    output logic aircon,
    output logic fan
);

always @(*) begin
    if (mode) begin // Heating mode
        heater = too_cold;
        aircon = 1'b0;
    end else begin // Cooling mode
        heater = 1'b0;
        aircon = too_hot;
    end
    fan = (heater || aircon || fan_on);
end

endmodule