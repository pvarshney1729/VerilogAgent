```verilog
[BEGIN]
module TopModule(
    input logic clk,
    input logic reset,
    input logic ena,
    output logic pm,
    output logic [7:0] hh,
    output logic [7:0] mm,
    output logic [7:0] ss
);

    // Internal registers
    logic [7:0] hh_reg, mm_reg, ss_reg;
    logic pm_reg;

    // Synchronous logic for clock timekeeping
    always_ff @(posedge clk) begin
        if (reset) begin
            // Reset condition
            hh_reg <= 8'b0001_0010; // BCD for 12
            mm_reg <= 8'b0000_0000; // BCD for 00
            ss_reg <= 8'b0000_0000; // BCD for 00
            pm_reg <= 1'b0;         // AM
        end else if (ena) begin
            // Increment seconds
            if (ss_reg == 8'b0101_1001) begin // BCD for 59
                ss_reg <= 8'b0000_0000; // Reset seconds to 00
                // Increment minutes
                if (mm_reg == 8'b0101_1001) begin // BCD for 59
                    mm_reg <= 8'b0000_0000; // Reset minutes to 00
                    // Increment hours
                    if (hh_reg == 8'b0001_0010) begin // BCD for 12
                        hh_reg <= 8'b0000_0001; // Reset hours to 01
                        pm_reg <= ~pm_reg;     // Toggle AM/PM
                    end else begin
                        hh_reg <= hh_reg + 8'b0000_0001; // Increment hours
                    end
                end else begin
                    mm_reg <= mm_reg + 8'b0000_0001; // Increment minutes
                end
            end else begin
                ss_reg <= ss_reg + 8'b0000_0001; // Increment seconds
            end
        end
    end

    // Assign outputs
    assign hh = hh_reg;
    assign mm = mm_reg;
    assign ss = ss_reg;
    assign pm = pm_reg;

endmodule
[DONE]
```