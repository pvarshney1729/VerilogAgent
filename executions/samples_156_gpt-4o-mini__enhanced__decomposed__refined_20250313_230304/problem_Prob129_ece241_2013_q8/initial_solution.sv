```verilog
[BEGIN]
module TopModule (
    input logic clk,
    input logic aresetn,
    input logic x,
    output logic z
);
    // State encoding
    typedef enum logic [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (!aresetn) begin
            current_state <= S0;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        next_state = current_state; // Default to hold state
        z = 1'b0;                   // Default output

        case (current_state)
            S0: begin
                if (x) begin
                    next_state = S1; // Transition to S1 on '1'
                end
            end
            S1: begin
                if (!x) begin
                    next_state = S2; // Transition to S2 on '0'
                end
            end
            S2: begin
                if (x) begin
                    next_state = S1; // Transition to S1 on '1'
                    z = 1'b1;        // Output '1' for detected sequence
                end else begin
                    next_state = S0; // Transition to S0 on '0'
                end
            end
        endcase
    end
endmodule
[DONE]
```