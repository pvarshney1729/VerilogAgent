```verilog
module TopModule(
    input logic clk,
    input logic areset,
    input logic j,
    input logic k,
    output logic out
);

    // State encoding
    typedef enum logic [0:0] {
        OFF = 1'b0,
        ON  = 1'b1
    } state_t;

    state_t state, next_state;

    // Asynchronous reset and state transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= OFF; // Reset to OFF state
            out <= 1'b0;  // Output is 0 in OFF state
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            OFF: begin
                if (j) begin
                    next_state = ON;
                    out = 1'b1;
                end else begin
                    next_state = OFF;
                    out = 1'b0;
                end
            end

            ON: begin
                if (k) begin
                    next_state = OFF;
                    out = 1'b0;
                end else begin
                    next_state = ON;
                    out = 1'b1;
                end
            end

            default: begin
                next_state = OFF;
                out = 1'b0;
            end
        endcase
    end

endmodule
```