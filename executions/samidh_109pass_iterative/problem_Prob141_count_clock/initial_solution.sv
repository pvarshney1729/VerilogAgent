module TopModule (
    input logic clk,
    input logic reset,
    input logic ena,
    output logic pm,
    output logic [7:0] hh,
    output logic [7:0] mm,
    output logic [7:0] ss
);

    always_ff @(posedge clk) begin
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
                    end else if (hh == 8'b00001011) begin // 11 in BCD
                        hh <= 8'b00010000; // Increment to 12
                    end else begin
                        hh <= hh + 1;
                    end
                end else if (mm[3:0] == 4'b1001) begin // x9 in BCD
                    mm <= {mm[7:4] + 1, 4'b0000}; // Increment tens
                end else begin
                    mm <= mm + 1;
                end
            end else if (ss[3:0] == 4'b1001) begin // x9 in BCD
                ss <= {ss[7:4] + 1, 4'b0000}; // Increment tens
            end else begin
                ss <= ss + 1;
            end
        end
    end

endmodule