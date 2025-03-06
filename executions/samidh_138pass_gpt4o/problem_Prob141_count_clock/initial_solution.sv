```verilog
module TopModule(
    input logic clk,
    input logic reset,
    input logic ena,
    output logic pm,
    output logic [7:0] hh,
    output logic [7:0] mm,
    output logic [7:0] ss
);

    // Internal registers for timekeeping
    logic [7:0] next_hh, next_mm, next_ss;
    logic next_pm;

    // Sequential logic for timekeeping
    always_ff @(posedge clk) begin
        if (reset) begin
            hh <= 8'b0001_0010; // BCD for 12
            mm <= 8'b0000_0000; // BCD for 00
            ss <= 8'b0000_0000; // BCD for 00
            pm <= 1'b0;         // AM
        end else if (ena) begin
            hh <= next_hh;
            mm <= next_mm;
            ss <= next_ss;
            pm <= next_pm;
        end
    end

    // Combinational logic for next state calculation
    always_comb begin
        // Default assignments
        next_ss = ss;
        next_mm = mm;
        next_hh = hh;
        next_pm = pm;

        // Increment seconds
        if (ss == 8'b0101_1001) begin // BCD 59
            next_ss = 8'b0000_0000;
            // Increment minutes
            if (mm == 8'b0101_1001) begin // BCD 59
                next_mm = 8'b0000_0000;
                // Increment hours
                if (hh == 8'b0001_0010) begin // BCD 12
                    next_hh = 8'b0001_0001; // BCD 01
                    next_pm = ~pm; // Toggle AM/PM
                end else if (hh == 8'b0001_0001) begin // BCD 11
                    next_hh = 8'b0001_0010; // BCD 12
                end else begin
                    next_hh = hh + 8'b0000_0001; // Increment hour
                end
            end else begin
                next_mm = mm + 8'b0000_0001; // Increment minute
            end
        end else begin
            next_ss = ss + 8'b0000_0001; // Increment second
        end
    end

endmodule
```