module TopModule (
    input logic clk,
    input logic reset,
    input logic j,
    input logic k,
    output logic state
);

    typedef enum logic [0:0] {
        OFF = 1'b0,
        ON = 1'b1
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= OFF;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            OFF: begin
                if (j && !k) begin
                    next_state = ON;
                end else begin
                    next_state = OFF;
                end
            end
            ON: begin
                if (!j && k) begin
                    next_state = OFF;
                end else begin
                    next_state = ON;
                end
            end
            default: next_state = OFF; // Default case to avoid latches
        endcase
    end

    // Output logic
    assign state = current_state;

endmodule