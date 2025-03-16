module TopModule (
    input logic clk,
    input logic reset,
    input logic ena,
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
                            if (hr_units == 4'b1001) begin
                                hr_units <= 4'b0000;
                                if (hr_tens == 4'b0001 && hr_units == 4'b0001) begin
                                    pm <= ~pm;
                                end
                                hr_tens <= (hr_tens == 4'b0001 && hr_units == 4'b0001) ? 4'b0000 : hr_tens;
                                hr_tens <= (hr_units == 4'b1001) ? hr_tens + 4'b0001 : hr_tens;
                            end else begin
                                hr_units <= hr_units + 4'b0001;
                            end
                        end else begin
                            min_tens <= min_tens + 4'b0001;
                        end
                    end else begin
                        min_units <= min_units + 4'b0001;
                    end
                end else begin
                    sec_units <= sec_units + 4'b0001;
                end
            end
        end
    end

    assign hh = {hr_tens, hr_units};
    assign mm = {min_tens, min_units};
    assign ss = {sec_tens, sec_units};

endmodule