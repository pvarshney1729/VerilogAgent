module TopModule
(
  input  logic       clk,
  input  logic       reset,
  input  logic [7:0] in,
  output logic       done
);

  // State definitions
  typedef enum logic [1:0] {IDLE, BYTE1, BYTE2, BYTE3} state_t;
  state_t current_state, next_state;

  // Sequential logic
  always_ff @( posedge clk or posedge reset ) begin
    if ( reset )
      current_state <= IDLE;
    else
      current_state <= next_state;
  end

  // Combinational logic
  always_comb begin
    next_state = current_state;
    done = 0;

    case (current_state)
      IDLE: begin
        if (in[3])
          next_state = BYTE1;
      end
      BYTE1: begin
        next_state = BYTE2;
      end
      BYTE2: begin
        next_state = BYTE3;
      end
      BYTE3: begin
        done = 1;
        if (in[3])
          next_state = BYTE1;
        else
          next_state = IDLE;
      end
    endcase
  end

endmodule