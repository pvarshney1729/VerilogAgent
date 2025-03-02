module TopModule (
    input logic clk,
    input logic reset,
    input logic temp_high,
    input logic temp_low,
    output logic heater,
    output logic cooler,
    output logic fan
);

    always @(*) begin
        // Default outputs
        heater = 1'b0;
        cooler = 1'b0;
        fan = 1'b0;

        // Control logic based on temperature inputs
        if (temp_high) begin
            cooler = 1'b1;
            fan = 1'b1;
        end else if (temp_low) begin
            heater = 1'b1;
            fan = 1'b1;
        end
    end

endmodule