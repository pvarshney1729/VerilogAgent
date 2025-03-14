[BEGIN]
```verilog
module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic ena,
    output logic pm,
    output logic [7:0] hh,
    output logic [7:0] mm,
    output logic [7:0] ss
);

    logic [3:0] sec_tens, sec_units;
    logic [3:0] min_tens, min_units;
    logic [3:0] hr_tens, hr_units;

    always @(posedge clk) begin
        if (reset) begin
            sec_tens <= 4'b0000;
            sec_units <= 4'b0000;
            min_tens <= 4'b0000;
            min_units <= 4'b0000;
            hr_tens <= 4'b0000;
            hr_units <= 4'b0000;
            pm <= 1'b0;
        end else if (ena) begin
            if (sec_units == 4'b1001) begin
                sec_units <= 4'b0000;
                if (sec_tens == 4'b0101) begin
                    sec_tens <= 4'b0000;
                    if (min_units == 4'b1001) begin
                        min_units <= 4'b0000;
                        if (min_tens == 4'b0101) begin
                            min_tens <= 4'b0000;
                            if (hr_units == 4'b0011 && hr_tens == 4'b0001) begin
                                hr_units <= 4'b0000;
                                hr_tens <= 4'b0000;
                                pm <= ~pm;
                            end else if (hr_units == 4'b1001) begin
                                hr_units <= 4'b0000;
                                hr_tens <= hr_tens + 4'b0001;
                            end else begin
                                hr_units <= hr_units + 4'b0001;
                            end
                        end else if (min_units == 4'b1001) begin
                            min_units <= 4'b0000;
                            min_tens <= min_tens + 4'b0001;
                        end else begin
                            min_units <= min_units + 4'b0001;
                        end
                    end else begin
                        sec_tens <= sec_tens + 4'b0001;
                    end
                end else begin
                    sec_units <= sec_units + 4'b0001;
                end
            end
        end
    end

    always @(*) begin
        ss = {sec_tens, sec_units};
        mm = {min_tens, min_units};
        hh = {hr_tens, hr_units};
    end

endmodule
```
[DONE]