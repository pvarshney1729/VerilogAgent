module TopModule
(
  input  logic       clk,
  input  logic       reset,
  input  logic [7:0] in,
  output logic [23:0] out_bytes,
  output logic       done
);

  // State machine states
  typedef enum logic [1:0] {IDLE, BYTE1, BYTE2, BYTE3} state_t;
  state_t state, next_state;

  // Registers for storing bytes
  logic [7:0] byte1, byte2, byte3;

  // Sequential logic
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      byte1 <= 0;
      byte2 <= 0;
      byte3 <= 0;
    end else begin
      state <= next_state;
      case (state)
        IDLE:  if (in[3]) byte1 <= in;
        BYTE1: byte2 <= in;
        BYTE2: byte3 <= in;
        default: ;
      endcase
    end
  end

  // Combinational logic
  always_comb begin
    next_state = state;
    case (state)
      IDLE:  if (in[3]) next_state = BYTE1;
      BYTE1: next_state = BYTE2;
      BYTE2: next_state = BYTE3;
      BYTE3: next_state = IDLE;
      default: next_state = IDLE;
    endcase
  end

  // Output connections
  assign out_bytes = {byte1, byte2, byte3};
  assign done = (state == BYTE3);

endmodule