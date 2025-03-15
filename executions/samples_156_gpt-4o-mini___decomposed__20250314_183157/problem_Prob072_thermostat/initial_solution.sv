module TopModule (
    input logic mode,
    input logic too_cold,
    input logic too_hot,
    input logic fan_on,
    output logic heater,
    output logic aircon,
    output logic fan
);

assign heater = mode && too_cold;       // Turn on heater in heating mode if too cold
assign aircon = ~mode && too_hot;        // Turn on air conditioner in cooling mode if too hot
assign fan = heater || aircon || fan_on; // Turn on fan if heater, aircon or fan_on is activated

endmodule