[BEGIN]
```verilog
module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic s,
    input  logic w,
    output logic z
);

    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;

    state_t current_state, next_state;
    logic [2:0] w_count;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= A;
            w_count <= 3'b000;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == B) begin
                w_count <= {w_count[1:0], w}; // Shift in the new w value
            end
            z <= (current_state == B && w_count == 3'b010) ? 1'b1 : 1'b0; // Set/reset z based on conditions
        end
    end

    always @(*) begin
        next_state = current_state; // Default to current state
        if (current_state == A) begin
            if (s) begin
                next_state = B;
            end
        end else if (current_state == B) begin
            if (w_count == 3'b010) begin
                next_state = B; // Stay in B
            end else begin
                next_state = A; // Return to A if conditions are not met
            end
        end
    end

endmodule
```
[DONE]