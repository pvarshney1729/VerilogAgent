module pattern_detector (
    input logic clk,
    input logic reset,
    input logic pattern_in,
    output logic detected,
    output logic ack
);

    logic [3:0] delay_counter;
    logic pattern_detected;
    
    // State for pattern detection
    always @(*) begin
        if (pattern_in) begin
            pattern_detected = 1'b1;
        end else begin
            pattern_detected = 1'b0;
        end
    end

    // Synchronous reset and delay counter
    always @(posedge clk) begin
        if (reset) begin
            delay_counter <= 4'b0000;
            detected <= 1'b0;
            ack <= 1'b0;
        end else begin
            if (pattern_detected) begin
                delay_counter <= 4'b1111; // Set delay to maximum
                detected <= 1'b1;
            end else if (delay_counter > 4'b0000) begin
                delay_counter <= delay_counter - 4'b0001; // Count down
            end else begin
                detected <= 1'b0;
            end
            
            // Acknowledge signal handling
            if (detected && delay_counter == 4'b0000) begin
                ack <= 1'b1; // Acknowledge when delay is complete
            end else begin
                ack <= 1'b0;
            end
        end
    end

endmodule