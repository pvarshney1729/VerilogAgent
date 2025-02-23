module TopModule
(
  input  logic       clk,
  input  logic       reset,
  input  logic [2:0] s,
  output logic       fr2,
  output logic       fr1,
  output logic       fr0,
  output logic       dfr
);

  // Sequential logic

  logic [2:0] prev_s;

  always @( posedge clk ) begin
    if ( reset )
      prev_s <= 3'b000;
    else
      prev_s <= s;
  end

  // Combinational logic

  always @(*) begin
    fr2 = fr1 = fr0 = dfr = 0;

    if ( s == 3'b000 ) begin
      fr2 = fr1 = fr0 = dfr = 1;
    end
    else if ( s == 3'b001 ) begin
      fr1 = fr0 = 1;
      if ( prev_s < s ) dfr = 1;
    end
    else if ( s == 3'b011 ) begin
      fr0 = 1;
      if ( prev_s < s ) dfr = 1;
    end
  end

endmodule