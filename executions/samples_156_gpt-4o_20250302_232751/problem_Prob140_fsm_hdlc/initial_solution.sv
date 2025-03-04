module TopModule (
    input  logic clk,          // Clock signal, positive edge-triggered
    input  logic reset,        // Synchronous active-high reset
    input  logic in,           // Serial data input
    output logic disc,         // Discard signal, active high
    output logic flag,         // Frame boundary flag, active high
    output logic err           // Error signal, active high
);

    typedef enum logic [3:0] {
        IDLE,
        S1,
        S11,
        S111,
        S1111,
        S11111,
        S111110,
        S1111110,
        S1111111
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        next_state = current_state;
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;
        
        case (current_state)
            IDLE: begin
                if (in) next_state = S1;
            end
            S1: begin
                if (in) next_state = S11;
                else next_state = IDLE;
            end
            S11: begin
                if (in) next_state = S111;
                else next_state = IDLE;
            end
            S111: begin
                if (in) next_state = S1111;
                else next_state = IDLE;
            end
            S1111: begin
                if (in) next_state = S11111;
                else next_state = IDLE;
            end
            S11111: begin
                if (in) next_state = S111110;
                else next_state = IDLE;
            end
            S111110: begin
                if (in) next_state = S1111110;
                else begin
                    next_state = IDLE;
                    disc = 1'b1;
                end
            end
            S1111110: begin
                if (in) next_state = S1111111;
                else begin
                    next_state = IDLE;
                    flag = 1'b1;
                end
            end
            S1111111: begin
                if (in) begin
                    next_state = S1111111;
                    err = 1'b1;
                end else begin
                    next_state = IDLE;
                end
            end
            default: next_state = IDLE;
        endcase
    end

endmodule