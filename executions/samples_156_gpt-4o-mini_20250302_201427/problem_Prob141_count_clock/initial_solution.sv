module TopModule (
    input logic clk,       // Clock signal (positive edge-triggered)
    input logic reset,     // Active high synchronous reset
    input logic ena,       // Enable signal for counting
    output logic pm,       // AM/PM indicator (1 for PM, 0 for AM)
    output logic [7:0] hh,  // Hours in BCD (01-12)
    output logic [7:0] mm,  // Minutes in BCD (00-59)
    output logic [7:0] ss   // Seconds in BCD (00-59)
);

    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'b0001_0010; // Set to 12 in BCD
            mm <= 8'b0000_0000; // Set to 00 in BCD
            ss <= 8'b0000_0000; // Set to 00 in BCD
            pm <= 1'b0;         // Set to AM
        end else if (ena) begin
            ss <= ss + 1;
            if (ss == 8'b0110_0000) begin // If ss rolls over to 60
                ss <= 8'b0000_0000; // Reset ss to 0
                mm <= mm + 1;
                if (mm == 8'b0110_0000) begin // If mm rolls over to 60
                    mm <= 8'b0000_0000; // Reset mm to 0
                    hh <= hh + 1;
                    if (hh == 8'b0001_0011) begin // If hh rolls over to 13
                        hh <= 8'b0001_0001; // Reset hh to 1
                        pm <= ~pm; // Toggle PM/AM
                    end
                end
            end
        end
    end

endmodule