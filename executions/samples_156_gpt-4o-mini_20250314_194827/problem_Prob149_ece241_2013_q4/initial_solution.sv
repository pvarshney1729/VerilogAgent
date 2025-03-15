module water_flow_control (
    input logic clk,
    input logic reset,
    input logic water_level_high,
    input logic water_level_low,
    output logic flow_rate_control,
    output logic dfr
);

    logic previous_dfr;

    always @(posedge clk) begin
        if (reset) begin
            flow_rate_control <= 1'b0;
            dfr <= 1'b0;
            previous_dfr <= 1'b0;
        end else begin
            // Flow rate control logic based on water level sensors
            if (water_level_high) begin
                flow_rate_control <= 1'b0; // Stop flow if high
            end else if (water_level_low) begin
                flow_rate_control <= 1'b1; // Allow flow if low
            end
            
            // Track previous state for dfr
            previous_dfr <= dfr;
            dfr <= flow_rate_control; // Update dfr based on flow rate control
        end
    end

endmodule