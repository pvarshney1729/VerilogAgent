module temperature_control (
    input logic clk,
    input logic reset,
    input logic [7:0] temperature,
    output logic heater,
    output logic aircon,
    output logic fan
);

    // Combinational logic for controlling heater, aircon, and fan
    always @(*) begin
        // Default outputs
        heater = 1'b0;
        aircon = 1'b0;
        fan = 1'b0;

        // Control logic based on temperature
        if (temperature < 8'd18) begin
            heater = 1'b1;
        end else if (temperature > 8'd24) begin
            aircon = 1'b1;
        end

        // Fan is on if either heater or aircon is on
        fan = heater | aircon;
    end

endmodule