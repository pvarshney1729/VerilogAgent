```verilog
module TopModule (
  input logic a,
  input logic b,
  input logic sel_b1,
  input logic sel_b2,
  output logic out_assign,
  output logic out_always
);

  // Combinational logic using assign statement
  assign out_assign = (sel_b1 && sel_b2) ? b : a;

  // Combinational logic using procedural block
  always_comb begin
    if (sel_b1 && sel_b2)
      out_always = b;
    else
      out_always = a;
  end

endmodule
```