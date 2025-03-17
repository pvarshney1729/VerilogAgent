module TopModule(
    input  logic mode,
    input  logic too_cold,
    input  logic too_hot,
    input  logic fan_on,
    output logic heater,
    output logic aircon,
    output logic fan
);

    // Heater logic: On in heating mode when too cold
    assign heater = mode & too_cold;

    // Air conditioner logic: On in cooling mode when too hot
    assign aircon = ~mode & too_hot;

    // Fan logic: On when heater or aircon is on, or when fan_on is requested
    assign fan = heater | aircon | fan_on;

endmodule