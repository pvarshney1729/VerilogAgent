module TopModule (
  input logic clk,          // Clock input
  input logic reset,        // Active-high synchronous reset
  input logic in,           // Input signal
  output logic out          // Output signal
);

  typedef enum logic {A, B} state_t;
  state_t current_state, next_state;

  always_ff @(posedge clk) begin
    if (reset) begin
      current_state <= B;
      out <= 1'b1;
    end else begin
      current_state <= next_state;
      out <= (current_state == B) ? 1'b1 : 1'b0;
    end
  end

  always_comb begin
    case (current_state)
      A: begin
        if (in) begin
          next_state = A;
        end else begin
          next_state = B;
        end
      end
      B: begin
        if (in) begin
          next_state = B;
        end else begin
          next_state = A;
        end
      end
      default: next_state = A; // Default case to avoid latches
    endcase
  end

endmodule