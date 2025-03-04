module TopModule (
  input logic clk,        // Clock input; positive edge triggered
  input logic areset,     // Asynchronous reset; active high
  input logic x,          // Serial input stream; least significant bit first
  output logic z          // Serial output stream; 2's complement of input
);

  typedef enum logic [1:0] {
    IDLE = 2'b00,
    INVERT = 2'b01,
    ADD_ONE = 2'b10
  } state_t;

  state_t current_state, next_state;
  logic carry;

  // State transition logic
  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      current_state <= IDLE;
      carry <= 1'b0;
    end else begin
      current_state <= next_state;
    end
  end

  // Next state logic
  always_comb begin
    case (current_state)
      IDLE: begin
        if (x == 1'b1) begin
          next_state = INVERT;
        end else begin
          next_state = IDLE;
        end
      end
      INVERT: begin
        next_state = ADD_ONE;
      end
      ADD_ONE: begin
        next_state = ADD_ONE;
      end
      default: begin
        next_state = IDLE;
      end
    endcase
  end

  // Output logic
  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      z <= 1'b0;
    end else begin
      case (current_state)
        IDLE: begin
          z <= x;
        end
        INVERT: begin
          z <= ~x;
        end
        ADD_ONE: begin
          z <= x ^ carry;
          carry <= x & carry;
        end
        default: begin
          z <= 1'b0;
        end
      endcase
    end
  end

endmodule