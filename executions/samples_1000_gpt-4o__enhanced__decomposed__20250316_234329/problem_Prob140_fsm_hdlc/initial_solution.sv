module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    typedef enum logic [2:0] {
        S_IDLE      = 3'b000,
        S_0         = 3'b001,
        S_01        = 3'b010,
        S_011       = 3'b011,
        S_0111      = 3'b100,
        S_01111     = 3'b101,
        S_011111    = 3'b110,
        S_0111111   = 3'b111
    } state_t;

    state_t current_state, next_state;

    // State register with synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= S_IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            S_IDLE: begin
                if (in == 1'b0)
                    next_state = S_0;
                else
                    next_state = S_IDLE;
            end
            S_0: begin
                if (in == 1'b1)
                    next_state = S_01;
                else
                    next_state = S_0;
            end
            S_01: begin
                if (in == 1'b1)
                    next_state = S_011;
                else
                    next_state = S_0;
            end
            S_011: begin
                if (in == 1'b1)
                    next_state = S_0111;
                else
                    next_state = S_0;
            end
            S_0111: begin
                if (in == 1'b1)
                    next_state = S_01111;
                else
                    next_state = S_0;
            end
            S_01111: begin
                if (in == 1'b1)
                    next_state = S_011111;
                else
                    next_state = S_0;
            end
            S_011111: begin
                if (in == 1'b0)
                    next_state = S_IDLE; // Transition to idle for disc
                else
                    next_state = S_0111111;
            end
            S_0111111: begin
                if (in == 1'b0)
                    next_state = S_IDLE; // Transition to idle for flag
                else
                    next_state = S_0111111; // Stay in error state
            end
            default: next_state = S_IDLE;
        endcase
    end

    // Output logic
    always_comb begin
        // Default assignments
        disc = 1'b0;
        flag = 1'b0;
        err  = 1'b0;
        
        case (current_state)
            S_011111: begin
                if (in == 1'b0)
                    disc = 1'b1; // Assert disc for 0111110
            end
            S_0111111: begin
                if (in == 1'b0)
                    flag = 1'b1; // Assert flag for 01111110
                else
                    err = 1'b1; // Assert err for 01111111...
            end
            default: begin
                // No output asserted
            end
        endcase
    end

endmodule