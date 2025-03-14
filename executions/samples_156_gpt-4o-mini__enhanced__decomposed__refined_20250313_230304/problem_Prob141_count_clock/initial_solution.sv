[BEGIN]
module TopModule (
    input logic clk,          // Clock signal (fast-running)
    input logic reset,        // Active high synchronous reset
    input logic ena,          // Enable signal (pulsed once per second)
    output logic pm,          // PM indicator output (1 bit)
    output logic [7:0] hh,    // Hours output (BCD, 8 bits - 01 to 12)
    output logic [7:0] mm,    // Minutes output (BCD, 8 bits - 00 to 59)
    output logic [7:0] ss      // Seconds output (BCD, 8 bits - 00 to 59)
);

    // Initial state
    initial begin
        hh = 8'h01; // Start at 1 AM
        mm = 8'h00; // Start at 00 minutes
        ss = 8'h00; // Start at 00 seconds
        pm = 1'b0;  // Start in AM
    end

    // Sequential logic
    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'h01; // Reset to 1 AM
            mm <= 8'h00; // Reset to 00 minutes
            ss <= 8'h00; // Reset to 00 seconds
            pm <= 1'b0;  // Reset to AM
        end else if (ena) begin
            if (ss == 8'h59) begin
                ss <= 8'h00; // Reset seconds
                if (mm == 8'h59) begin
                    mm <= 8'h00; // Reset minutes
                    if (hh == 8'h12) begin
                        hh <= 8'h01; // Reset hours
                        pm <= ~pm;   // Toggle AM/PM
                    end else begin
                        hh <= hh + 8'h01; // Increment hour
                    end
                end else begin
                    mm <= mm + 8'h01; // Increment minutes
                end
            end else begin
                ss <= ss + 8'h01; // Increment seconds
            end
        end
    end

endmodule
[DONE]