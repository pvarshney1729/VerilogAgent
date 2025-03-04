module TopModule(
    input logic clk,       // Clock signal
    input logic reset,     // Active-high synchronous reset
    input logic in,        // State machine input
    output logic out       // State machine output
);

    typedef enum logic {A, B} state_t;
    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            B: begin
                if (in == 1'b0) begin
                    next_state = A;
                end else begin
                    next_state = B;
                end
            end
            A: begin
                if (in == 1'b0) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
        endcase
    end

    // State update and output logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= B;
            out <= 1'b1;
        end else begin
            current_state <= next_state;
            out <= (current_state == B) ? 1'b1 : 1'b0;
        end
    end

endmodule