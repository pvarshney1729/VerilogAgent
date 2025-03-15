module TopModule(
    input logic clk,
    input logic reset,
    input logic ena,
    output logic pm,
    output logic [7:0] hh,
    output logic [7:0] mm,
    output logic [7:0] ss
);

    // Internal registers for hours, minutes, and seconds
    logic [7:0] hours, minutes, seconds;
    logic pm_flag;

    // Sequential logic for the clock
    always_ff @(posedge clk) begin
        if (reset) begin
            // Reset the clock to 12:00:00 AM
            hours <= 8'b00010010; // BCD for 12
            minutes <= 8'b00000000; // BCD for 00
            seconds <= 8'b00000000; // BCD for 00
            pm_flag <= 1'b0; // AM
        end else if (ena) begin
            // Increment seconds
            if (seconds == 8'b01011001) begin // BCD for 59
                seconds <= 8'b00000000;
                // Increment minutes
                if (minutes == 8'b01011001) begin // BCD for 59
                    minutes <= 8'b00000000;
                    // Increment hours
                    if (hours == 8'b00010010) begin // BCD for 12
                        hours <= 8'b00000001; // BCD for 01
                        pm_flag <= ~pm_flag; // Toggle AM/PM
                    end else if (hours == 8'b00001001) begin // BCD for 09
                        hours <= 8'b00010000; // BCD for 10
                    end else begin
                        hours <= hours + 8'b00000001;
                    end
                end else if (minutes[3:0] == 4'b1001) begin // BCD digit 9
                    minutes <= {minutes[7:4] + 4'b0001, 4'b0000};
                end else begin
                    minutes <= minutes + 8'b00000001;
                end
            end else if (seconds[3:0] == 4'b1001) begin // BCD digit 9
                seconds <= {seconds[7:4] + 4'b0001, 4'b0000};
            end else begin
                seconds <= seconds + 8'b00000001;
            end
        end
    end

    // Output assignments
    assign hh = hours;
    assign mm = minutes;
    assign ss = seconds;
    assign pm = pm_flag;

endmodule