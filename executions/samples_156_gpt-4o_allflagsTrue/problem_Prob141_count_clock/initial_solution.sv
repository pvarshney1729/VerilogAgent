module TopModule(
    input logic clk,
    input logic reset,
    input logic ena,
    output logic pm,
    output logic [7:0] hh,
    output logic [7:0] mm,
    output logic [7:0] ss
);

    // Internal registers for BCD counting
    logic [3:0] hh_ones;
    logic [3:0] hh_tens;
    logic [3:0] mm_ones;
    logic [3:0] mm_tens;
    logic [3:0] ss_ones;
    logic [3:0] ss_tens;

    // Synchronous reset and clock logic
    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'b0001_0010; // 12 in BCD
            mm <= 8'b0000_0000; // 00 in BCD
            ss <= 8'b0000_0000; // 00 in BCD
            pm <= 1'b0;         // AM
        end else if (ena) begin
            // Seconds counter
            if (ss == 8'b0101_1001) begin // 59 in BCD
                ss <= 8'b0000_0000; // Reset to 00
                // Minutes counter
                if (mm == 8'b0101_1001) begin // 59 in BCD
                    mm <= 8'b0000_0000; // Reset to 00
                    // Hours counter
                    if (hh == 8'b0001_0010) begin // 12 in BCD
                        hh <= 8'b0000_0001; // Reset to 01
                        pm <= ~pm; // Toggle PM
                    end else if (hh == 8'b0000_1001) begin // 09 in BCD
                        hh <= 8'b0001_0000; // Increment to 10
                    end else if (hh == 8'b0001_0000) begin // 10 in BCD
                        hh <= 8'b0001_0001; // Increment to 11
                    end else if (hh == 8'b0001_0001) begin // 11 in BCD
                        hh <= 8'b0001_0010; // Increment to 12
                    end else begin
                        hh <= hh + 1; // Increment hours
                    end
                end else begin
                    if (mm[3:0] == 4'b1001) begin // Lower BCD digit is 9
                        mm <= {mm[7:4] + 1'b1, 4'b0000}; // Increment tens place
                    end else begin
                        mm <= mm + 1; // Increment minutes
                    end
                end
            end else begin
                if (ss[3:0] == 4'b1001) begin // Lower BCD digit is 9
                    ss <= {ss[7:4] + 1'b1, 4'b0000}; // Increment tens place
                end else begin
                    ss <= ss + 1; // Increment seconds
                end
            end
        end
    end

endmodule