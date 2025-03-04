```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic ena,
    output logic pm,
    output logic [7:0] hh,
    output logic [7:0] mm,
    output logic [7:0] ss
);

    // Internal registers for BCD representation
    logic [3:0] hh_ones, hh_tens;
    logic [3:0] mm_ones, mm_tens;
    logic [3:0] ss_ones, ss_tens;

    // Combinational logic to update BCD outputs
    always_comb begin
        hh = {hh_tens, hh_ones};
        mm = {mm_tens, mm_ones};
        ss = {ss_tens, ss_ones};
    end

    // Sequential logic for timekeeping
    always_ff @(posedge clk) begin
        if (reset) begin
            // Reset condition
            hh_ones <= 4'b0010; // BCD 2
            hh_tens <= 4'b0001; // BCD 1
            mm_ones <= 4'b0000; // BCD 0
            mm_tens <= 4'b0000; // BCD 0
            ss_ones <= 4'b0000; // BCD 0
            ss_tens <= 4'b0000; // BCD 0
            pm <= 1'b0; // AM
        end else if (ena) begin
            // Increment seconds
            if (ss_ones == 4'b1001) begin
                ss_ones <= 4'b0000;
                if (ss_tens == 4'b0101) begin
                    ss_tens <= 4'b0000;
                    // Increment minutes
                    if (mm_ones == 4'b1001) begin
                        mm_ones <= 4'b0000;
                        if (mm_tens == 4'b0101) begin
                            mm_tens <= 4'b0000;
                            // Increment hours
                            if (hh_ones == 4'b1001) begin
                                hh_ones <= 4'b0000;
                                if (hh_tens == 4'b0001) begin
                                    hh_tens <= 4'b0000;
                                    pm <= ~pm; // Toggle AM/PM
                                end else begin
                                    hh_tens <= hh_tens + 1;
                                end
                            end else if (hh_ones == 4'b0010 && hh_tens == 4'b0001) begin
                                hh_ones <= 4'b0001;
                                hh_tens <= 4'b0000;
                                pm <= ~pm; // Toggle AM/PM
                            end else begin
                                hh_ones <= hh_ones + 1;
                            end
                        end else begin
                            mm_tens <= mm_tens + 1;
                        end
                    end else begin
                        mm_ones <= mm_ones + 1;
                    end
                end else begin
                    ss_tens <= ss_tens + 1;
                end
            end else begin
                ss_ones <= ss_ones + 1;
            end
        end
    end

endmodule
```