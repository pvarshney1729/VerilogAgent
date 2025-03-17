module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);

    // Define the states
    typedef enum logic [0:0] {
        A = 1'b0,
        B = 1'b1
    } state_t;

    // Declare the current and next state signals
    state_t current_state, next_state;

    // State transition logic with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            current_state <= B;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            B: begin
                if (in == 1'b0)
                    next_state = A;
                else
                    next_state = B;
            end
            A: begin
                if (in == 1'b0)
                    next_state = B;
                else
                    next_state = A;
            end
            default: next_state = B; // Default to reset state
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            B: out = 1'b1;
            A: out = 1'b0;
            default: out = 1'b1;
        endcase
    end

endmodule