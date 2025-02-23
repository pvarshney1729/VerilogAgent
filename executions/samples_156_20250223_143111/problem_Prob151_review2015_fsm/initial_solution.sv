module TopModule
(
  input  logic clk,
  input  logic reset,
  input  logic data,
  input  logic done_counting,
  input  logic ack,
  output logic shift_ena,
  output logic counting,
  output logic done
);

  // State encoding

  typedef enum logic [2:0] {IDLE, SHIFT, COUNT, NOTIFY, WAIT} state_t;

  // Sequential logic

  state_t state, next_state;
  logic [3:0] pattern;

  always @( posedge clk or posedge reset ) begin
    if ( reset ) begin
      state <= IDLE;
      pattern <= 4'b0;
    end else begin
      state <= next_state;
      if ( state == IDLE || state == SHIFT )
        pattern <= pattern << 1 | data;
    end
  end

  // Combinational logic

  always @(*) begin
    next_state = state;
    shift_ena = 0;
    counting = 0;
    done = 0;

    case ( state )
      IDLE: begin
        if ( pattern == 4'b1101 )
          next_state = SHIFT;
      end
      SHIFT: begin
        shift_ena = 1;
        if ( pattern == 4'b1101 )
          next_state = COUNT;
      end
      COUNT: begin
        counting = 1;
        if ( done_counting )
          next_state = NOTIFY;
      end
      NOTIFY: begin
        done = 1;
        if ( ack )
          next_state = WAIT;
      end
      WAIT: begin
        if ( !ack )
          next_state = IDLE;
      end
    endcase
  end

endmodule