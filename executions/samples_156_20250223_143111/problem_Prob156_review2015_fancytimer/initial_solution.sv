module TopModule
(
  input  logic clk,
  input  logic reset,
  input  logic data,
  output logic [3:0] count,
  output logic counting,
  output logic done,
  input  logic ack
);

  // State definitions
  typedef enum logic [2:0] {IDLE, DETECT, LOAD, COUNT, WAIT} state_t;
  state_t state, next_state;

  // Internal signals
  logic [3:0] delay;
  logic [3:0] delay_count;
  logic [9:0] cycle_count;
  logic [3:0] pattern;
  logic pattern_match;

  // State transition and output logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      pattern <= 4'b0000;
    end else begin
      state <= next_state;
      if (state == DETECT) begin
        pattern <= pattern << 1;
        pattern[0] <= data;
      end else if (state == LOAD) begin
        delay <= delay << 1;
        delay[0] <= data;
      end
    end
  end

  // Next state logic
  always @(*) begin
    pattern_match = (pattern == 4'b1101);
    next_state = state;
    case (state)
      IDLE:   if (pattern_match) next_state = LOAD;
      DETECT: if (pattern_match) next_state = LOAD;
              else next_state = DETECT;
      LOAD:   if (pattern[0]) next_state = COUNT;
              else next_state = LOAD;
      COUNT:  if (cycle_count == 0) next_state = WAIT;
              else next_state = COUNT;
      WAIT:   if (ack) next_state = DETECT;
              else next_state = WAIT;
    endcase
  end

  // Counting logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      cycle_count <= 0;
      delay_count <= 0;
    end else if (state == COUNT) begin
      if (cycle_count == 0) begin
        cycle_count <= 1000;
        delay_count <= delay_count - 1;
      end else begin
        cycle_count <= cycle_count - 1;
      end
    end
  end

  // Output logic
  assign counting = (state == COUNT);
  assign done = (state == WAIT);
  assign count = delay_count;

endmodule