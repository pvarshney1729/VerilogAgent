module TopModule(
    input logic mode,        // 1-bit input. Mode of operation: 0 for cooling, 1 for heating.
    input logic too_cold,    // 1-bit input. High when the environment is too cold.
    input logic too_hot,     // 1-bit input. High when the environment is too hot.
    input logic fan_on,      // 1-bit input. High to manually turn on the fan.
    input logic rst,         // Synchronous reset input.
    output logic heater,     // 1-bit output. High to turn on the heater.
    output logic aircon,     // 1-bit output. High to turn on the air conditioner.
    output logic fan         // 1-bit output. High to turn on the fan.
);

    always @(*) begin
        if (rst) begin
            heater = 1'b0;
            aircon = 1'b0;
            fan = 1'b0;
        end else begin
            heater = mode & too_cold;
            aircon = ~mode & too_hot;
            fan = (mode & too_cold) | (~mode & too_hot) | fan_on;
        end
    end

endmodule