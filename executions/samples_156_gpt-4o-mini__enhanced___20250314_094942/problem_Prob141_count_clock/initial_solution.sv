module TopModule (
    input logic clk,           // Clock signal (fast-running)
    input logic reset,         // Active high synchronous reset
    input logic ena,           // Enable signal for clock increments (active high)
    output logic pm,           // PM indicator (1 for PM, 0 for AM)
    output logic [7:0] hh,     // Hours in BCD format (01 to 12)
    output logic [7:0] mm,     // Minutes in BCD format (00 to 59)
    output logic [7:0] ss       // Seconds in BCD format (00 to 59)
);

    // Initial values
    initial begin
        hh = 8'b00001100; // 12
        mm = 8'b00000000; // 00
        ss = 8'b00000000; // 00
        pm = 1'b0;        // AM
    end

    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'b00001100; // Reset to 12
            mm <= 8'b00000000; // Reset to 00
            ss <= 8'b00000000; // Reset to 00
            pm <= 1'b0;        // Reset to AM
        end else if (ena) begin
            // Increment seconds
            if (ss == 8'b00111001) begin // 59
                ss <= 8'b00000000; // Reset seconds to 00
                // Increment minutes
                if (mm == 8'b00111001) begin // 59
                    mm <= 8'b00000000; // Reset minutes to 00
                    // Increment hours
                    if (hh == 8'b00001100) begin // 12
                        hh <= 8'b00000001; // Reset hours to 01
                        pm <= ~pm; // Toggle PM/AM
                    end else begin
                        hh <= hh + 1; // Increment hours
                    end
                end else begin
                    mm <= mm + 1; // Increment minutes
                end
            end else begin
                ss <= ss + 1; // Increment seconds
            end
        end
    end
endmodule