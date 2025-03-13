[BEGIN]
module TopModule(
    input logic clk,             // Clock signal, positive edge-triggered
    input logic reset,           // Active high synchronous reset
    input logic ena,             // Enable signal for incrementing time
    output logic pm,             // AM/PM indicator, 1 for PM, 0 for AM
    output logic [7:0] hh,       // Hours in BCD format (01-12)
    output logic [7:0] mm,       // Minutes in BCD format (00-59)
    output logic [7:0] ss         // Seconds in BCD format (00-59)
);

always @(posedge clk) begin
    if (reset) begin
        hh <= 8'b00010010; // 12 in BCD
        mm <= 8'b00000000; // 00 in BCD
        ss <= 8'b00000000; // 00 in BCD
        pm <= 1'b0;        // AM
    end else if (ena) begin
        // Increment seconds
        if (ss == 8'b01011001) begin // 59 in BCD
            ss <= 8'b00000000; // Reset to 00
            // Increment minutes
            if (mm == 8'b01011001) begin // 59 in BCD
                mm <= 8'b00000000; // Reset to 00
                // Increment hours
                if (hh == 8'b00010010) begin // 12 in BCD
                    hh <= 8'b00000001; // Reset to 01
                    pm <= ~pm; // Toggle AM/PM
                end else if (hh == 8'b00010001) begin // 11 in BCD
                    hh <= 8'b00010010; // Increment to 12
                end else begin
                    hh <= hh + 8'b00000001; // Increment hours
                end
            end else begin
                mm <= mm + 8'b00000001; // Increment minutes
            end
        end else begin
            ss <= ss + 8'b00000001; // Increment seconds
        end
    end
end

endmodule
[DONE]