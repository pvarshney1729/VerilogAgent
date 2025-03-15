module climate_control (
    input logic temperature,
    input logic humidity,
    input logic sunlight,
    output logic fan,
    output logic heater,
    output logic humidifier
);

    always @(*) begin
        fan = (temperature > 75) ? 1'b1 : 1'b0;
        heater = (temperature < 65) ? 1'b1 : 1'b0;
        humidifier = (humidity < 30) ? 1'b1 : 1'b0;
    end

endmodule