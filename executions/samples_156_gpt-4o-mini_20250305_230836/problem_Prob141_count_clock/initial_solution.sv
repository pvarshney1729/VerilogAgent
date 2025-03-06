[BEGIN]
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

    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'b0001_0010; // 12 in BCD
            mm <= 8'b0000_0000; // 00 in BCD
            ss <= 8'b0000_0000; // 00 in BCD
            pm <= 1'b0;         // AM
        end else if (ena) begin
            if (ss == 8'b0101_1001) begin // 59 in BCD
                ss <= 8'b0000_0000; // Reset seconds to 00
                if (mm == 8'b0101_1001) begin // 59 in BCD
                    mm <= 8'b0000_0000; // Reset minutes to 00
                    if (hh == 8'b0001_0010) begin // 12 in BCD
                        hh <= 8'b0000_0001; // Reset hours to 01
                        pm <= ~pm; // Toggle PM/AM
                    end else begin
                        hh <= hh + 8'b0000_0001; // Increment hours
                    end
                end else begin
                    mm <= mm + 8'b0000_0001; // Increment minutes
                end
            end else begin
                ss <= ss + 8'b0000_0001; // Increment seconds
            end
        end
    end

endmodule
```
[DONE]