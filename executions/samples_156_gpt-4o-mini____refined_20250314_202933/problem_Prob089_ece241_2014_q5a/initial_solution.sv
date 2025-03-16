[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        IDLE,
        COUNT,
        OUTPUT
    } state_t;

    state_t current_state, next_state;
    logic [31:0] count; // Assuming a maximum of 32 bits for the input

    always_ff @(posedge clk) begin
        if (areset) begin
            current_state <= IDLE;
            count <= 32'b0;
        end else begin
            current_state <= next_state;
            if (current_state == COUNT) begin
                count <= {x, count[31:1]}; // Shift in the new bit
            end
        end
    end

    always_ff @(posedge clk) begin
        if (!areset) begin
            case (current_state)
                IDLE: next_state <= COUNT;
                COUNT: next_state <= (count[31] == 1'b1) ? OUTPUT : COUNT;
                OUTPUT: next_state <= IDLE; // Go back to IDLE after output
                default: next_state <= IDLE; // Default case for safety
            endcase
        end else begin
            next_state <= IDLE; // Synchronous reset behavior
        end
    end

    assign z = (current_state == OUTPUT) ? ~count + 1'b1 : 1'b0; // 2's complement

endmodule
```
[DONE]