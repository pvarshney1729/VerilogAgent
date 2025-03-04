module TopModule (
    input  logic clk,     // Clock input, positive edge-triggered
    input  logic reset,   // Synchronous, active-high reset
    input  logic in,      // Serial data input
    output logic disc,    // Output: 1 when a bit is to be discarded
    output logic flag,    // Output: 1 when a frame boundary is detected
    output logic err      // Output: 1 when an error is detected
);

    typedef enum logic [3:0] {
        Idle, One, Two, Three, Four, Five, Six, Flag, Error
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= Idle;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        // Default assignments
        next_state = current_state;
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

        case (current_state)
            Idle: begin
                if (in) next_state = One;
            end
            One: begin
                if (in) next_state = Two;
                else next_state = Idle;
            end
            Two: begin
                if (in) next_state = Three;
                else next_state = Idle;
            end
            Three: begin
                if (in) next_state = Four;
                else next_state = Idle;
            end
            Four: begin
                if (in) next_state = Five;
                else next_state = Idle;
            end
            Five: begin
                if (in) next_state = Six;
                else next_state = Idle;
            end
            Six: begin
                if (in) begin
                    next_state = Error;
                    err = 1'b1;
                end else begin
                    next_state = Flag;
                    flag = 1'b1;
                end
            end
            Flag: begin
                next_state = Idle;
            end
            Error: begin
                if (!in) next_state = Idle;
            end
        endcase
    end

endmodule