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
        // Heating Mode
        if (mode) begin
            heater = too_cold;
            aircon = 1'b0;
            fan = heater | fan_on;
        end
        // Cooling Mode
        else begin
            heater = 1'b0;
            aircon = too_hot;
            fan = aircon | fan_on;
        end
    end

endmodule