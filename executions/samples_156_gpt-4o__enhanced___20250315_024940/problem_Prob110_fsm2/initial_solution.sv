module TopModule (
    input  logic clk,
    input  logic areset,
    input  logic j,
    input  logic k,
    output logic out
);

    typedef enum logic {OFF, ON} state_t;
    state_t current_state, next_state;

    // Asynchronous reset to OFF state
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= OFF;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic to determine the next state
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
            default: begin
                next_state = OFF; // Default state handling
            end
        endcase
    end

    // Output logic based on the current state
    assign out = (current_state == ON) ? 1'b1 : 1'b0;

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly