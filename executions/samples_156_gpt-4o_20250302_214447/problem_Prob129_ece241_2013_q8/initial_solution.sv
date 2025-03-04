[BEGIN]
module TopModule (
    input  wire clk,       // Clock signal, positive edge-triggered
    input  wire aresetn,   // Active-low asynchronous reset
    input  wire x,         // Input signal for sequence detection
    output reg  z          // Output signal, asserted when "101" sequence is detected
);

    typedef enum logic [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S0: begin
                if (x) next_state = S1;
                else next_state = S0;
            end
            S1: begin
                if (x) next_state = S1;
                else next_state = S2;
            end
            S2: begin
                if (x) next_state = S1;
                else next_state = S0;
            end
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(*) begin
        z = 1'b0;
        case (current_state)
            S2: begin
                if (x) z = 1'b1;
            end
            default: z = 1'b0;
        endcase
    end

endmodule
[END]

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly