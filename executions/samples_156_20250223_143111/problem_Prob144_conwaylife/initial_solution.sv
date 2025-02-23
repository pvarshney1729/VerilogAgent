module TopModule
(
  input  logic       clk,
  input  logic       load,
  input  logic [255:0] data,
  output logic [255:0] q
);

  // Sequential logic

  logic [255:0] reg_q;

  always @( posedge clk ) begin
    if ( load )
      reg_q <= data;
    else
      reg_q <= next_state(reg_q);
  end

  // Combinational logic

  function [255:0] next_state;
    input [255:0] current_state;
    integer i;
    integer j;
    integer count;
    begin
      for (i = 0; i < 16; i = i + 1) begin
        for (j = 0; j < 16; j = j + 1) begin
          count = current_state[i-1+:16][j-1] + current_state[i-1+:16][j] + current_state[i-1+:16][j+1] +
                  current_state[i][j-1] + current_state[i][j+1] +
                  current_state[i+1+:16][j-1] + current_state[i+1+:16][j] + current_state[i+1+:16][j+1];
          if (count < 2 || count > 3)
            next_state[i+:16][j] = 0;
          else if (count == 3)
            next_state[i+:16][j] = 1;
          else
            next_state[i+:16][j] = current_state[i+:16][j];
        end
      end
    end
  endfunction

  // Structural connections

  assign q = reg_q;

endmodule