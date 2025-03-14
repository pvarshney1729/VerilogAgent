[BEGIN]
module TopModule (
    input logic clk,       // 1-bit clock signal
    input logic reset,     // 1-bit active high synchronous reset
    input logic [7:0] in,  // 8-bit input data from the PS/2 mouse
    output logic done      // 1-bit output signal indicating message completion
);

    // State encoding for the FSM
    typedef enum logic [2:0] {
        IDLE  = 3'b000,  // Waiting for in[3]=1
        BYTE1 = 3'b001,  // First byte of the message detected
        BYTE2 = 3'b010,  // Second byte of the message detected
        BYTE3 = 3'b011,  // Third byte of the message detected
        DONE  = 3'b100   // Message complete
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset and state transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational block for next state logic and done signal
    always @(*) begin
        // Default outputs
        next_state = current_state;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1)
                    next_state = BYTE1;
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = DONE;
            end
            DONE: begin
                done = 1'b1; // Assert done for one cycle
                next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
[DONE]