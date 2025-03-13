```verilog
[BEGIN]
module TopModule (
    input logic clk,
    input logic aresetn,
    input logic x,
    output logic z
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        S1   = 2'b01,
        S10  = 2'b10
    } state_t;

    state_t current_state, next_state;

    // Sequential state transition with synchronous reset
    always_ff @(posedge clk) begin
        if (!aresetn) begin
            current_state <= IDLE;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for state transition and output
    always_comb begin
        // Default assignments
        next_state = current_state;
        z = 1'b0;

        case (current_state)
            IDLE: begin
                if (x) begin
                    next_state = S1;
                end
            end
            S1: begin
                if (!x) begin
                    next_state = S10;
                end
            end
            S10: begin
                if (x) begin
                    next_state = S1; // detect "101"
                    z = 1'b1;
                end else begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule
[DONE]
```