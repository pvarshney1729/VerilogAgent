```verilog
[BEGIN]
module TopModule (
  input logic clk,      // Clock signal, positive edge-triggered
  input logic reset,    // Synchronous active-high reset
  input logic in,       // Input data stream, 1 bit
  output logic disc,    // Output signal to discard a bit, 1 bit
  output logic flag,    // Output signal for frame flag, 1 bit
  output logic err      // Output signal for error condition, 1 bit
);

  // State encoding
  typedef enum logic [3:0] {
    State_0,    // Initial/Idle state
    State_1,    // 1 consecutive '1'
    State_2,    // 2 consecutive '1's
    State_3,    // 3 consecutive '1's
    State_4,    // 4 consecutive '1's
    State_5,    // 5 consecutive '1's
    State_Disc, // 0111110 detected
    State_Flag, // 01111110 detected
    State_Error  // 7 or more consecutive '1's detected
  } state_t;

  state_t current_state, next_state;

  // State transition on clock edge
  always @(posedge clk) begin
    if (reset) begin
      current_state <= State_0;
      disc <= 1'b0;
      flag <= 1'b0;
      err <= 1'b0;
    end else begin
      current_state <= next_state;
    end
  end

  // Next state logic
  always @(*) begin
    // Default assignments
    next_state = current_state;
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;

    case (current_state)
      State_0: begin
        if (in) next_state = State_1;
      end
      
      State_1: begin
        if (in) next_state = State_2;
        else next_state = State_0;
      end
      
      State_2: begin
        if (in) next_state = State_3;
        else next_state = State_0;
      end
      
      State_3: begin
        if (in) next_state = State_4;
        else next_state = State_0;
      end
      
      State_4: begin
        if (in) next_state = State_5;
        else next_state = State_0;
      end
      
      State_5: begin
        if (in) next_state = State_Error;
        else next_state = State_Disc;
      end
      
      State_Disc: begin
        disc = 1'b1;
        next_state = State_0;
      end
      
      State_Flag: begin
        flag = 1'b1;
        next_state = State_0;
      end
      
      State_Error: begin
        err = 1'b1;
        if (!in) next_state = State_0; // Reset on zero
      end
      
      default: next_state = State_0;
    endcase
  end

  // Output logic based on state
  always @(posedge clk) begin
    if (reset) begin
      disc <= 1'b0;
      flag <= 1'b0;
      err <= 1'b0;
    end else begin
      case (next_state)
        State_Disc: disc <= 1'b1;
        State_Flag: flag <= 1'b1;
        State_Error: err <= 1'b1;
        default: begin
          disc <= 1'b0;
          flag <= 1'b0;
          err <= 1'b0;
        end
      endcase
    end
  end

endmodule
[DONE]
```