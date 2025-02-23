module TopModule
(
  input  logic clk,
  input  logic reset,
  input  logic ena,
  output logic pm,
  output logic [7:0] hh,
  output logic [7:0] mm,
  output logic [7:0] ss
);

  // Sequential logic

  logic [5:0] count_ss, count_mm, count_hh;
  logic pm_reg;

  always @( posedge clk ) begin
    if ( reset ) begin
      count_ss <= 0;
      count_mm <= 0;
      count_hh <= 1;
      pm_reg <= 0;
    end
    else if ( ena ) begin
      if ( count_ss == 59 ) begin
        count_ss <= 0;
        if ( count_mm == 59 ) begin
          count_mm <= 0;
          if ( count_hh == 12 ) begin
            count_hh <= 1;
            pm_reg <= ~pm_reg;
          end
          else
            count_hh <= count_hh + 1;
        end
        else
          count_mm <= count_mm + 1;
      end
      else
        count_ss <= count_ss + 1;
    end
  end

  // Combinational logic

  assign ss = count_ss;
  assign mm = count_mm;
  assign hh = count_hh;
  assign pm = pm_reg;

endmodule