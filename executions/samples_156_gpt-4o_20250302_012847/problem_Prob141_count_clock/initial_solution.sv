module clock_module (
    input logic clk,
    input logic reset,
    output logic [7:0] hh,
    output logic [7:0] mm,
    output logic [7:0] ss,
    output logic am_pm // 0 for AM, 1 for PM
);

    // Internal registers for hours, minutes, and seconds
    logic [7:0] hours;
    logic [7:0] minutes;
    logic [7:0] seconds;
    logic am_pm_flag;

    // Synchronous reset and clock logic
    always_ff @(posedge clk) begin
        if (reset) begin
            // Initialize to 12:00:00 AM
            hours <= 8'd12;
            minutes <= 8'd0;
            seconds <= 8'd0;
            am_pm_flag <= 1'b0; // AM
        end else begin
            // Increment seconds
            if (seconds == 8'd59) begin
                seconds <= 8'd0;
                // Increment minutes
                if (minutes == 8'd59) begin
                    minutes <= 8'd0;
                    // Increment hours
                    if (hours == 8'd11) begin
                        hours <= 8'd12;
                        am_pm_flag <= ~am_pm_flag; // Toggle AM/PM
                    end else if (hours == 8'd12) begin
                        hours <= 8'd1;
                    end else begin
                        hours <= hours + 1;
                    end
                end else begin
                    minutes <= minutes + 1;
                end
            end else begin
                seconds <= seconds + 1;
            end
        end
    end

    // Assign outputs
    assign hh = hours;
    assign mm = minutes;
    assign ss = seconds;
    assign am_pm = am_pm_flag;

endmodule