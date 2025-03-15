module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic in,
    output logic done
);
    // State encoding
    typedef enum logic [2:0] {
        IDLE,          // Idle state, waiting for start bit
        START_BIT,    // Start bit detected
        DATA_0,       // Receiving data bit 0
        DATA_1,       // Receiving data bit 1
        DATA_2,       // Receiving data bit 2
        DATA_3,       // Receiving data bit 3
        DATA_4,       // Receiving data bit 4
        DATA_5,       // Receiving data bit 5
        DATA_6,       // Receiving data bit 6
        DATA_7,       // Receiving data bit 7
        STOP_BIT      // Stop bit expected
    } state_t;

    state_t current_state, next_state;
    logic [7:0] data; // To hold the received data bits

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // State machine to handle reception
    always @(*) begin
        // Default next state
        next_state = current_state;
        done = 1'b0; // Default done signal is low

        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    next_state = START_BIT;
                end
            end
            
            START_BIT: begin
                next_state = DATA_0; // Move to receive first data bit
            end
            
            DATA_0: next_state = DATA_1;
            DATA_1: next_state = DATA_2;
            DATA_2: next_state = DATA_3;
            DATA_3: next_state = DATA_4;
            DATA_4: next_state = DATA_5;
            DATA_5: next_state = DATA_6;
            DATA_6: next_state = DATA_7;
            DATA_7: next_state = STOP_BIT;
            
            STOP_BIT: begin
                if (in == 1'b1) begin // Stop bit detected
                    done = 1'b1; // Signal that a byte has been successfully received
                    next_state = IDLE; // Go back to idle
                end else begin
                    // If stop bit is not detected, stay in STOP_BIT state
                    next_state = STOP_BIT;
                end
            end
            
            default: next_state = IDLE; // Fallback to idle on unknown state
        endcase
    end
endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly