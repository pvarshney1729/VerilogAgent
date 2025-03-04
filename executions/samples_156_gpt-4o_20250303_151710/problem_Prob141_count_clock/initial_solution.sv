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
            hh <= 8'd12;
            mm <= 8'd0;
            ss <= 8'd0;
            pm <= 1'b0;
        end else if (ena) begin
            if (ss == 8'd59) begin
                ss <= 8'd0;
                if (mm == 8'd59) begin
                    mm <= 8'd0;
                    if (hh == 8'd12) begin
                        hh <= 8'd1;
                        pm <= ~pm;
                    end else if (hh == 8'd11) begin
                        hh <= 8'd12;
                    end else begin
                        hh <= hh + 8'd1;
                    end
                end else begin
                    mm <= mm + 8'd1;
                end
            end else begin
                ss <= ss + 8'd1;
            end
        end
    end

endmodule