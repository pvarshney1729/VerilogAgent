[BEGIN]
module TopModule (
    input  logic clk,       // Clock signal (1-bit)
    input  logic reset,     // Active high synchronous reset (1-bit)
    input  logic in,        // Input data stream (1-bit)
    output logic disc,      // Discard signal (1-bit)
    output logic flag,      // Frame flag signal (1-bit)
    output logic err        // Error signal (1-bit)
);

localparam [2:0] 
    IDLE     = 3'b000,
    ONE      = 3'b001,
    TWO      = 3'b010,
    THREE    = 3'b011,
    FOUR     = 3'b100,
    FIVE     = 3'b101,
    SIX      = 3'b110,
    ERROR    = 3'b111;

logic [2:0] state, next_state;

// Synchronous reset and state transition
always @(posedge clk) begin
    if (reset) begin
        state <= IDLE; // Initialize FSM to IDLE state
    end else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (state)
        IDLE: begin
            next_state = in ? ONE : IDLE;
        end
        ONE: begin
            next_state = in ? TWO : IDLE;
        end
        TWO: begin
            next_state = in ? THREE : IDLE;
        end
        THREE: begin
            next_state = in ? FOUR : IDLE;
        end
        FOUR: begin
            next_state = in ? FIVE : IDLE;
        end
        FIVE: begin
            next_state = in ? SIX : IDLE;
        end
        SIX: begin
            next_state = in ? ERROR : IDLE;
        end
        ERROR: begin
            next_state = ERROR; // Remain in ERROR state
        end
        default: begin
            next_state = IDLE; // Default case to handle unexpected states
        end
    endcase
end

// Output logic
always @(*) begin
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;
    case (state)
        SIX: begin
            disc = 1'b1; // Signal to discard
        end
        ERROR: begin
            err = 1'b1; // Signal an error
        end
        default: begin
            if (state == SIX && !in) begin
                flag = 1'b1; // Signal frame flag for 01111110
            end
        end
    endcase
end

endmodule
[DONE]