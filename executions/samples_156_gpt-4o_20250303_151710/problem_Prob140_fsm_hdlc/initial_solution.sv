module TopModule (
    input  logic clk,       // Clock input, positive edge triggered
    input  logic reset,     // Synchronous active-high reset
    input  logic in,        // Input data stream
    output logic disc,      // Output signal to indicate a bit to discard
    output logic flag,      // Output signal to indicate a frame boundary
    output logic err        // Output signal to indicate an error condition
);

    typedef enum logic [3:0] {
        S_IDLE   = 4'd0,
        S_ONE    = 4'd1,
        S_TWO    = 4'd2,
        S_THREE  = 4'd3,
        S_FOUR   = 4'd4,
        S_FIVE   = 4'd5,
        S_SIX    = 4'd6,
        S_FLAG   = 4'd7,
        S_DISC   = 4'd8,
        S_ERROR  = 4'd9
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= S_IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        // Default assignments
        next_state = current_state;
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

        case (current_state)
            S_IDLE: begin
                if (in) next_state = S_ONE;
            end
            S_ONE: begin
                if (in) next_state = S_TWO;
                else next_state = S_IDLE;
            end
            S_TWO: begin
                if (in) next_state = S_THREE;
                else next_state = S_IDLE;
            end
            S_THREE: begin
                if (in) next_state = S_FOUR;
                else next_state = S_IDLE;
            end
            S_FOUR: begin
                if (in) next_state = S_FIVE;
                else next_state = S_IDLE;
            end
            S_FIVE: begin
                if (in) next_state = S_SIX;
                else next_state = S_DISC;
            end
            S_SIX: begin
                if (in) next_state = S_ERROR;
                else next_state = S_FLAG;
            end
            S_FLAG: begin
                flag = 1'b1;
                next_state = S_IDLE;
            end
            S_DISC: begin
                disc = 1'b1;
                next_state = S_IDLE;
            end
            S_ERROR: begin
                err = 1'b1;
                next_state = S_IDLE;
            end
            default: next_state = S_IDLE;
        endcase
    end

endmodule