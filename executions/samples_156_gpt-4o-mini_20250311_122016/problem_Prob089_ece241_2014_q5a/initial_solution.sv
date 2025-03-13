[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        FOUND_ONE = 2'b01,
        COMPLEMENT = 2'b10
    } state_t;

    state_t current_state, next_state;

    // Sequential logic for state transition with synchronous reset
    always @(posedge clk) begin
        if (areset) begin
            current_state <= IDLE;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for state transition
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (x == 1'b1) begin
                    next_state = FOUND_ONE;
                end else begin
                    next_state = IDLE;
                end
            end
            FOUND_ONE: begin
                next_state = COMPLEMENT;
            end
            COMPLEMENT: begin
                next_state = COMPLEMENT;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Output logic based on current state
    always @(*) begin
        case (current_state)
            IDLE: z = 1'b0; // Output 0 until the first '1' is encountered
            FOUND_ONE: z = 1'b1; // Output the first '1'
            COMPLEMENT: z = ~x; // Complement subsequent bits
            default: z = 1'b0;
        endcase
    end

endmodule
```
[DONE]