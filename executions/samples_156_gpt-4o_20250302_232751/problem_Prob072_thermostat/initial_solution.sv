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
        // Default assignments
        heater = 1'b0;
        aircon = 1'b0;
        fan = 1'b0;

        if (mode) begin
            // Heating Mode
            heater = too_cold;
            aircon = 1'b0;
            fan = heater || fan_on;
        end else begin
            // Cooling Mode
            aircon = too_hot;
            heater = 1'b0;
            fan = aircon || fan_on;
        end
    end

endmodule