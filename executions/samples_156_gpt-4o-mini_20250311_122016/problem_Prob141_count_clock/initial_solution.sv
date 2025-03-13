[BEGIN]
module TopModule (
    input logic clk,          // System clock input
    input logic reset,        // Active high synchronous reset
    input logic ena,          // Enable pulse for clock increment (once per second)
    output logic pm,          // PM indicator, 1 for PM, 0 for AM
    output logic [7:0] hh,    // Hours in BCD format (01-12)
    output logic [7:0] mm,    // Minutes in BCD format (00-59)
    output logic [7:0] ss      // Seconds in BCD format (00-59)
);

    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'b0001_0010; // BCD for 12
            mm <= 8'b0000_0000; // BCD for 00
            ss <= 8'b0000_0000; // BCD for 00
            pm <= 1'b0;         // AM
        end else if (ena) begin
            // Increment seconds
            if (ss == 8'b0101_1001) begin // 59 seconds
                ss <= 8'b0000_0000; // Reset seconds to 00
                // Increment minutes
                if (mm == 8'b0101_1001) begin // 59 minutes
                    mm <= 8'b0000_0000; // Reset minutes to 00
                    // Increment hours
                    if (hh == 8'b0001_0010) begin // 12 hours
                        hh <= 8'b0000_0001; // Reset to 01
                        pm <= ~pm;          // Toggle AM/PM
                    end else if (hh == 8'b0000_1001) begin // 09 hours
                        hh <= 8'b0001_0000; // Increment to 10
                    end else begin
                        hh <= hh + 1; // Increment hour
                    end
                end else begin
                    mm <= mm + 1; // Increment minute
                end
            end else begin
                ss <= ss + 1; // Increment second
            end
        end
    end

endmodule
[DONE]