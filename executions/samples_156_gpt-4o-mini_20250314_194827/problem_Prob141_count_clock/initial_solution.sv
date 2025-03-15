module bcd_clock (
    input logic clk,
    input logic reset,
    output logic [3:0] hours,
    output logic [3:0] minutes,
    output logic [3:0] seconds,
    output logic am_pm
);

    logic [3:0] hour_count;
    logic [5:0] minute_count;
    logic [5:0] second_count;

    always @(posedge clk) begin
        if (reset) begin
            hour_count <= 4'b0000;
            minute_count <= 6'b000000;
            second_count <= 6'b000000;
            am_pm <= 1'b0; // AM
        end else begin
            // Increment seconds
            if (second_count == 6'b111011) begin // 59
                second_count <= 6'b000000;
                // Increment minutes
                if (minute_count == 6'b111011) begin // 59
                    minute_count <= 6'b000000;
                    // Increment hours
                    if (hour_count == 4'b1100) begin // 12
                        hour_count <= 4'b0001; // Reset to 1
                        am_pm <= ~am_pm; // Toggle AM/PM
                    end else begin
                        hour_count <= hour_count + 4'b0001;
                    end
                end else begin
                    minute_count <= minute_count + 6'b000001;
                end
            end else begin
                second_count <= second_count + 6'b000001;
            end
        end
    end

    assign hours = hour_count;
    assign minutes = minute_count[5:4] * 4'b1010 + minute_count[3:0]; // Convert to BCD
    assign seconds = second_count[5:4] * 4'b1010 + second_count[3:0]; // Convert to BCD

endmodule