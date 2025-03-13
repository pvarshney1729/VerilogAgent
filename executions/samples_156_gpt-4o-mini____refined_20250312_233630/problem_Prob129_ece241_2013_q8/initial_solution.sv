[BEGIN]
```verilog
module TopModule (
    input  logic clk,
    input  logic aresetn,
    input  logic x,
    output logic z
);

    typedef enum logic [1:0] {
        S0 = 2'b00, // Initial state
        S1 = 2'b01, // State after '1'
        S2 = 2'b10  // State after '10'
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset
    always_ff @(posedge clk) begin
        if (!aresetn) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for state transitions and output
    always @(*) begin
        z = 1'b0; // Default output
        next_state = current_state; // Default to hold state
        case (current_state)
            S0: begin
                if (x) begin
                    next_state = S1;
                end
            end
            S1: begin
                if (x) begin
                    next_state = S1;
                end else begin
                    next_state = S2;
                end
            end
            S2: begin
                if (x) begin
                    next_state = S1;
                    z = 1'b1; // Output high when "101" is detected
                end else begin
                    next_state = S0;
                end
            end
            default: begin
                next_state = S0;
            end
        endcase
    end

endmodule
```
[DONE]