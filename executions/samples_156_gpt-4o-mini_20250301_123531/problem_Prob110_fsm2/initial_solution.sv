module TopModule (
    input logic clk,
    input logic areset,
    input logic j,
    input logic k,
    output logic out
);

    typedef enum logic [1:0] {
        OFF = 2'b00,
        ON  = 2'b01
    } state_t;

    state_t current_state, next_state;

    // Asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= OFF;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
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
            default: next_state = OFF; // Default case to avoid latches
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
            OFF: out = 1'b0;
            ON:  out = 1'b1;
            default: out = 1'b0; // Default case to avoid latches
        endcase
    end

endmodule