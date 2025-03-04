```verilog
module TopModule (
  input logic clk,           // Clock signal, positive edge triggered
  input logic reset,         // Active high synchronous reset
  input logic in,            // Data input stream
  output logic disc,         // Output signal to indicate a bit to discard
  output logic flag,         // Output signal to indicate frame boundary
  output logic err           // Output signal to indicate error on 7+ consecutive 1s
);

  typedef enum logic [2:0] {
    Idle,
    One_1,
    Two_1s,
    Three_1s,
    Four_1s,
    Five_1s,
    Six_1s,
    Flag,
    Discard,
    Error
  } state_t;

  state_t current_state, next_state;

  // State register
  always_ff @(posedge clk) begin
    if (reset) begin
      current_state <= Idle;
    end else begin
      current_state <= next_state;
    end
  end

  // Next state logic
  always_comb begin
    // Default assignments
    next_state = current_state;
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;

    case (current_state)
      Idle: begin
        if (in) next_state = One_1;
      end
      One_1: begin
        if (in) next_state = Two_1s;
        else next_state = Idle;
      end
      Two_1s: begin
        if (in) next_state = Three_1s;
        else next_state = Idle;
      end
      Three_1s: begin
        if (in) next_state = Four_1s;
        else next_state = Idle;
      end
      Four_1s: begin
        if (in) next_state = Five_1s;
        else next_state = Idle;
      end
      Five_1s: begin
        if (in) next_state = Six_1s;
        else next_state = Idle;
      end
      Six_1s: begin
        if (in) next_state = Error;
        else next_state = Flag;
      end
      Flag: begin
        flag = 1'b1;
        next_state = Idle;
      end
      Discard: begin
        disc = 1'b1;
        next_state = Idle;
      end
      Error: begin
        err = 1'b1;
        if (!reset) next_state = Error;
      end
      default: next_state = Idle;
    endcase
  end

endmodule
```