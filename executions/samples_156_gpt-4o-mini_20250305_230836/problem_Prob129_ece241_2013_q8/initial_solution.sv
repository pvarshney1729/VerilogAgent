module TopModule (
    input logic clk,
    input logic aresetn,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        next_state = current_state;
        z = 1'b0; // Default output

        case (current_state)
            S0: begin
                if (x) begin
                    next_state = S1;
                end
            end
            S1: begin
                if (!x) begin
                    next_state = S2;
                end
            end
            S2: begin
                if (x) begin
                    z = 1'b1; // Sequence '101' detected
                    next_state = S1; // Overlapping sequence
                end else begin
                    next_state = S2; // Stay in S2 if '0'
                end
            end
        endcase
    end

endmodule