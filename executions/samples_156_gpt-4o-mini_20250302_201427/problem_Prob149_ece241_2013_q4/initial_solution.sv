module TopModule (
    input logic clk,                    // Clock signal
    input logic reset,                  // Active-high synchronous reset
    input logic [2:0] s,                // 3-bit sensor input: s[2] = highest, s[0] = lowest
    output logic fr2,                   // Output control for flow rate level 2
    output logic fr1,                   // Output control for flow rate level 1
    output logic fr0,                   // Output control for flow rate level 0
    output logic dfr                    // Output control for supplemental flow rate
);

    typedef enum logic [1:0] {
        State0 = 2'b00, // Above s[2]
        State1 = 2'b01, // Between s[2] and s[1]
        State2 = 2'b10, // Between s[1] and s[0]
        State3 = 2'b11  // Below s[0]
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= State3; // Reset to State3
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            fr0 <= 1'b1;
            dfr <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        fr2 = 1'b1; fr1 = 1'b1; fr0 = 1'b1; dfr = 1'b0; // Default values
        case (current_state)
            State0: begin
                if (s[2]) begin
                    next_state = State0;
                    fr2 = 1'b0; fr1 = 1'b0; fr0 = 1'b0; dfr = 1'b0;
                end else if (s[1]) begin
                    next_state = State1;
                    fr2 = 1'b0; fr1 = 1'b0; fr0 = 1'b1; dfr = 1'b0;
                end else if (s[0]) begin
                    next_state = State2;
                    fr2 = 1'b0; fr1 = 1'b1; fr0 = 1'b1; dfr = 1'b0;
                end else begin
                    next_state = State3;
                end
            end
            State1: begin
                next_state = (s[2]) ? State0 : (s[1]) ? State1 : (s[0]) ? State2 : State3;
                fr2 = 1'b0; fr1 = 1'b0; fr0 = 1'b1; dfr = 1'b0;
            end
            State2: begin
                next_state = (s[2]) ? State0 : (s[1]) ? State1 : (s[0]) ? State2 : State3;
                fr2 = 1'b0; fr1 = 1'b1; fr0 = 1'b1; dfr = 1'b0;
            end
            State3: begin
                next_state = (s[2]) ? State0 : (s[1]) ? State1 : (s[0]) ? State2 : State3;
            end
            default: begin
                next_state = State3;
            end
        endcase
    end

endmodule