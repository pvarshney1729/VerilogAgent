module TopModule(
    input wire mode,
    input wire too_cold,
    input wire too_hot,
    input wire fan_on,
    output reg heater,
    output reg aircon,
    output reg fan
);

always @(*) begin
    // Default outputs
    heater = 1'b0;
    aircon = 1'b0;
    fan = 1'b0;

    if (mode) begin
        // Heating Mode
        if (too_cold) begin
            heater = 1'b1;
        end
        fan = heater | fan_on;
    end else begin
        // Cooling Mode
        if (too_hot) begin
            aircon = 1'b1;
        end
        fan = aircon | fan_on;
    end
end

endmodule