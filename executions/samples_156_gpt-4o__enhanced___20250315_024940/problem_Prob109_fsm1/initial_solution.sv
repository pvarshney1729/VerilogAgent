module TopModule (
    input  logic clk,
    input  logic areset,
    input  logic in,
    output logic out
);

    // State encoding
    typedef enum logic {
        A = 1'b0,
        B = 1'b1
    } state_t;

    // State register
    state_t state, next_state;

    // Asynchronous reset to State B
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= B;  // Reset to State B
        end else begin
            state <= next_state;  // Update state on clock edge
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (in == 1'b0) 
                    next_state = B;  // Transition from A to B on input 0
                else 
                    next_state = A;  // Stay in A on input 1
            end
            
            B: begin
                if (in == 1'b0) 
                    next_state = A;  // Transition from B to A on input 0
                else 
                    next_state = B;  // Stay in B on input 1
            end
            
            default: next_state = B;  // Default state (should not happen)
        endcase
    end

    // Output logic (Moore machine output based on current state)
    assign out = state;  // Output is directly the current state

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly