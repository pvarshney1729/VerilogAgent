module TopModule(
  input logic clk,        // Clock input, positive edge triggered
  input logic resetn,     // Synchronous active-low reset
  input logic x,          // 1-bit input from motor
  input logic y,          // 1-bit input from motor
  output logic f,         // 1-bit output controlling motor
  output logic g          // 1-bit output controlling motor
);

  typedef enum logic [1:0] {
    STATE_A = 2'b00,
    STATE_MONITOR = 2'b01,
    STATE_SEQUENCE_DETECTED = 2'b10,
    STATE_G_PERMANENT = 2'b11
  } state_t;

  state_t current_state, next_state;
  logic [1:0] sequence_counter;
  logic y_counter;

  always_ff @(posedge clk) begin
    if (!resetn) begin
      current_state <= STATE_A;
      f <= 1'b0;
      g <= 1'b0;
      sequence_counter <= 2'b00;
      y_counter <= 1'b0;
    end else begin
      current_state <= next_state;
      if (current_state == STATE_A) begin
        f <= 1'b1;
      end else begin
        f <= 1'b0;
      end
    end
  end

  always_ff @(posedge clk) begin
    if (current_state == STATE_SEQUENCE_DETECTED) begin
      g <= 1'b1;
    end else if (current_state == STATE_G_PERMANENT) begin
      g <= 1'b1;
    end else begin
      g <= 1'b0;
    end
  end

  always_comb begin
    next_state = current_state;
    case (current_state)
      STATE_A: begin
        if (resetn) begin
          next_state = STATE_MONITOR;
        end
      end
      STATE_MONITOR: begin
        if (x == 1'b1 && sequence_counter == 2'b00) begin
          sequence_counter = 2'b01;
        end else if (x == 1'b0 && sequence_counter == 2'b01) begin
          sequence_counter = 2'b10;
        end else if (x == 1'b1 && sequence_counter == 2'b10) begin
          next_state = STATE_SEQUENCE_DETECTED;
          sequence_counter = 2'b00;
        end else begin
          sequence_counter = 2'b00;
        end
      end
      STATE_SEQUENCE_DETECTED: begin
        if (y == 1'b1) begin
          next_state = STATE_G_PERMANENT;
        end else if (y_counter == 1'b1) begin
          next_state = STATE_MONITOR;
        end else begin
          y_counter = 1'b1;
        end
      end
      STATE_G_PERMANENT: begin
        // Remain in this state
      end
    endcase
  end

endmodule