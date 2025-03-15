module TopModule (
    input logic clk,
    input logic reset,
    input logic w,
    output logic z
);

    // State encoding
    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;

    // State variable
    state_t current_state, next_state;

    // Output logic: z is high when in state E
    assign z = (current_state == E);

    // Sequential logic for state transitions
    always @(posedge clk) begin
        if (reset) begin
            current_state <= A; // Reset to state A
        end else begin
            current_state <= next_state; // Update to next state
        end
    end

    // Combinational logic for next state determination
    always @(*) begin
        case (current_state)
            A: begin
                if (w == 1'b0) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            B: begin
                if (w == 1'b0) begin
                    next_state = C;
                end else begin
                    next_state = D;
                end
            end
            C: begin
                if (w == 1'b0) begin
                    next_state = E;
                end else begin
                    next_state = D;
                end
            end
            D: begin
                if (w == 1'b0) begin
                    next_state = F;
                end else begin
                    next_state = A;
                end
            end
            E: begin
                if (w == 1'b0) begin
                    next_state = E;
                end else begin
                    next_state = D;
                end
            end
            F: begin
                if (w == 1'b0) begin
                    next_state = C;
                end else begin
                    next_state = D;
                end
            end
            default: begin
                next_state = A; // Default to state A for safety
            end
        endcase
    end

endmodule