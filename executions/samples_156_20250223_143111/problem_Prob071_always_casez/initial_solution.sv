module TopModule
(
  input  logic [7:0] in,
  output logic [2:0] pos
);

  // Combinational logic

  always @(*) begin
    if (in[0]) pos = 3'd1;
    else if (in[1]) pos = 3'd2;
    else if (in[2]) pos = 3'd3;
    else if (in[3]) pos = 3'd4;
    else if (in[4]) pos = 3'd5;
    else if (in[5]) pos = 3'd6;
    else if (in[6]) pos = 3'd7;
    else if (in[7]) pos = 3'd8;
    else pos = 3'd0;
  end

endmodule