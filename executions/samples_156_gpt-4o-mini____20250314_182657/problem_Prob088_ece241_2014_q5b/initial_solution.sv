module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        A = 2'b01,
        B = 2'b10
    } state_t;

    state_t current_state, next_state;

    // Asynchronous reset to state A
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            A: begin
                if (x) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            B: begin
                next_state = B; // Remain in B
            end
            default: next_state = A; // Default to A
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            A: z = x; // z = 1 when x = 1
            B: z = ~x; // z = 1 when x = 0
            default: z = 1'b0; // Default output
        endcase
    end

endmodule