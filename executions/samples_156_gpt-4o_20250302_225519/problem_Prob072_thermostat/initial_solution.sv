module TopModule(
    input logic mode,       // 1-bit, unsigned
    input logic too_cold,   // 1-bit, unsigned
    input logic too_hot,    // 1-bit, unsigned
    input logic fan_on,     // 1-bit, unsigned
    output logic heater,    // 1-bit, unsigned
    output logic aircon,    // 1-bit, unsigned
    output logic fan        // 1-bit, unsigned
);

    always @(*) begin
        if (mode) begin
            // Heating Mode
            heater = too_cold ? 1'b1 : 1'b0;
            aircon = 1'b0;
            fan = (heater || fan_on) ? 1'b1 : 1'b0;
        end else begin
            // Cooling Mode
            aircon = too_hot ? 1'b1 : 1'b0;
            heater = 1'b0;
            fan = (aircon || fan_on) ? 1'b1 : 1'b0;
        end
    end

endmodule