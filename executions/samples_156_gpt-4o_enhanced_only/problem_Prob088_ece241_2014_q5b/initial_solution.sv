module TopModule (
    input  logic clk,
    input  logic areset,
    input  logic x,
    output logic z
);

    // State encoding using one-hot representation
    typedef enum logic [1:0] {
        A = 2'b10,  // State A
        B = 2'b01   // State B
    } state_t;

    state_t current_state, next_state;

    // Asynchronous reset and state transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= A;  // Reset to state A
        end else begin
            current_state <= next_state;
        end
    end

    // Next state and output logic
    always_comb begin
        case (current_state)
            A: begin
                if (x) begin
                    next_state = B;
                    z = 1;
                end else begin
                    next_state = A;
                    z = 0;
                end
            end
            B: begin
                if (x) begin
                    next_state = B;
                    z = 0;
                end else begin
                    next_state = B;
                    z = 1;
                end
            end
            default: begin
                next_state = A;  // Default to state A
                z = 0;
            end
        endcase
    end

endmodule