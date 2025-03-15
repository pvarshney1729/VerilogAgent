module TopModule (
    input logic clk,
    input logic areset,
    input logic j,
    input logic k,
    output logic out
);

    typedef enum logic {OFF, ON} state_t;
    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            OFF: begin
                if (j) begin
                    next_state = ON;
                end else begin
                    next_state = OFF;
                end
            end
            ON: begin
                if (k) begin
                    next_state = OFF;
                end else begin
                    next_state = ON;
                end
            end
            default: next_state = OFF; // Default case
        endcase
    end

    // State update logic with synchronous reset
    always @(posedge clk) begin
        if (areset) begin
            current_state <= OFF;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    assign out = (current_state == ON);

endmodule