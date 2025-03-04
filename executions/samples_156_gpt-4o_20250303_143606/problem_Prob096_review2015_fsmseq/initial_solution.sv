```verilog
module TopModule (
    input  logic clk,          // Clock signal, positive edge-triggered
    input  logic reset,        // Synchronous active-high reset
    input  logic data,         // Input data bit stream
    output logic start_shifting // Output signal, asserted high when sequence detected
);

    typedef enum logic [2:0] {
        IDLE     = 3'b000,
        S1       = 3'b001,
        S11      = 3'b010,
        S110     = 3'b011,
        DETECTED = 3'b100
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            start_shifting <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DETECTED)
                start_shifting <= 1'b1;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            IDLE: begin
                if (data)
                    next_state = S1;
                else
                    next_state = IDLE;
            end
            S1: begin
                if (data)
                    next_state = S11;
                else
                    next_state = IDLE;
            end
            S11: begin
                if (data)
                    next_state = S11;
                else
                    next_state = S110;
            end
            S110: begin
                if (data)
                    next_state = DETECTED;
                else
                    next_state = IDLE;
            end
            DETECTED: begin
                if (reset)
                    next_state = IDLE;
                else
                    next_state = DETECTED;
            end
            default: next_state = IDLE;
        endcase
    end

endmodule
```