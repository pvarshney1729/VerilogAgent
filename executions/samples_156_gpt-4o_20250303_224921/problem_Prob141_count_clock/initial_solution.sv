module TopModule (
    input logic clk,
    input logic reset,
    input logic ena,
    output logic pm,
    output logic [7:0] hh,
    output logic [7:0] mm,
    output logic [7:0] ss
);

    // Internal registers for counting
    logic [7:0] hh_next, mm_next, ss_next;
    logic pm_next;

    // Synchronous logic for clock and reset
    always_ff @(posedge clk) begin
        if (reset) begin
            hh <= 8'b0001_0010; // 12 in BCD
            mm <= 8'b0000_0000; // 00 in BCD
            ss <= 8'b0000_0000; // 00 in BCD
            pm <= 1'b0;         // AM
        end else if (ena) begin
            hh <= hh_next;
            mm <= mm_next;
            ss <= ss_next;
            pm <= pm_next;
        end
    end

    // Combinational logic for next state calculation
    always_comb begin
        // Default assignments
        hh_next = hh;
        mm_next = mm;
        ss_next = ss;
        pm_next = pm;

        // Increment seconds
        if (ss == 8'b0101_1001) begin // 59 in BCD
            ss_next = 8'b0000_0000; // Reset to 00
            // Increment minutes
            if (mm == 8'b0101_1001) begin // 59 in BCD
                mm_next = 8'b0000_0000; // Reset to 00
                // Increment hours
                if (hh == 8'b0001_0010) begin // 12 in BCD
                    hh_next = 8'b0000_0001; // Reset to 01
                    pm_next = ~pm; // Toggle AM/PM
                end else if (hh == 8'b0001_0001) begin // 11 in BCD
                    hh_next = 8'b0001_0010; // Go to 12
                end else begin
                    hh_next = hh + 8'b0000_0001; // Increment hours
                end
            end else begin
                mm_next = mm + 8'b0000_0001; // Increment minutes
            end
        end else begin
            ss_next = ss + 8'b0000_0001; // Increment seconds
        end
    end

endmodule