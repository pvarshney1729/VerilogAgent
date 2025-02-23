module TopModule
(
  input  logic clk,
  input  logic in,
  input  logic reset,
  output logic [7:0] out_byte,
  output logic done
);

  // State definitions
  typedef enum logic [2:0] {IDLE, START, DATA, STOP} state_t;
  state_t current_state, next_state;

  // Data register
  logic [7:0] data_reg;
  logic [3:0] bit_count;

  // FSM logic
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= IDLE;
      data_reg <= 0;
      bit_count <= 0;
      done <= 0;
    end else begin
      current_state <= next_state;
      if (next_state == DATA) begin
        data_reg[bit_count] <= in;
        bit_count <= bit_count + 1;
      end
      if (next_state == STOP) begin
        done <= 1;
      end else begin
        done <= 0;
      end
    end
  end

  // Next state logic
  always_comb begin
    case (current_state)
      IDLE: begin
        if (in == 0) next_state = START;
        else next_state = IDLE;
      end
      START: begin
        if (in == 1) next_state = DATA;
        else next_state = START;
      end
      DATA: begin
        if (bit_count == 7) next_state = STOP;
        else next_state = DATA;
      end
      STOP: begin
        if (in == 1) next_state = IDLE;
        else next_state = STOP;
      end
    endcase
  end

  // Output assignment
  assign out_byte = data_reg;

endmodule