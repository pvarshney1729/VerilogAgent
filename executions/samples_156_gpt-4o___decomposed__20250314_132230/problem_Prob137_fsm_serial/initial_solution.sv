module TopModule (
  input  logic clk,
  input  logic reset,
  input  logic in,
  output logic done
);

  // Define states for the FSM
  typedef enum logic [3:0] {
    IDLE      = 4'b0000,
    START_BIT = 4'b0001,
    DATA_0    = 4'b0010,
    DATA_1    = 4'b0011,
    DATA_2    = 4'b0100,
    DATA_3    = 4'b0101,
    DATA_4    = 4'b0110,
    DATA_5    = 4'b0111,
    DATA_6    = 4'b1000,
    DATA_7    = 4'b1001,
    STOP_BIT  = 4'b1010,
    ERROR     = 4'b1011
  } state_t;

  state_t current_state, next_state;
  logic [2:0] bit_counter;

  // State transition logic
  always_ff @(posedge clk) begin
    if (reset) begin
      current_state <= IDLE;
      bit_counter <= 3'd0;
      done <= 1'b0;
    end else begin
      current_state <= next_state;
      if (current_state == START_BIT || current_state == DATA_0 || current_state == DATA_1 ||
          current_state == DATA_2 || current_state == DATA_3 || current_state == DATA_4 ||
          current_state == DATA_5 || current_state == DATA_6 || current_state == DATA_7) begin
        bit_counter <= bit_counter + 3'd1;
      end else begin
        bit_counter <= 3'd0;
      end
    end
  end

  // Next state logic
  always_comb begin
    next_state = current_state;
    done = 1'b0;
    case (current_state)
      IDLE: begin
        if (in == 1'b0) begin
          next_state = START_BIT;
        end
      end
      START_BIT: begin
        next_state = DATA_0;
      end
      DATA_0: begin
        next_state = DATA_1;
      end
      DATA_1: begin
        next_state = DATA_2;
      end
      DATA_2: begin
        next_state = DATA_3;
      end
      DATA_3: begin
        next_state = DATA_4;
      end
      DATA_4: begin
        next_state = DATA_5;
      end
      DATA_5: begin
        next_state = DATA_6;
      end
      DATA_6: begin
        next_state = DATA_7;
      end
      DATA_7: begin
        next_state = STOP_BIT;
      end
      STOP_BIT: begin
        if (in == 1'b1) begin
          done = 1'b1;
          next_state = IDLE;
        end else begin
          next_state = ERROR;
        end
      end
      ERROR: begin
        if (in == 1'b1) begin
          next_state = IDLE;
        end
      end
    endcase
  end

endmodule