```verilog
[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    input logic s,
    input logic w,
    output logic z
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t current_state, next_state;
    logic [1:0] w_count; // Counter for 'w' occurrences
    logic [1:0] cycle_count; // Cycle counter for three clock cycles

    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
            z <= 1'b0;
            w_count <= 2'b00;
            cycle_count <= 2'b00;
        end else begin
            current_state <= next_state;

            if (current_state == STATE_B) begin
                if (cycle_count < 2'b10) begin
                    cycle_count <= cycle_count + 1'b1;
                    if (w) begin
                        w_count <= w_count + 1'b1;
                    end
                end else begin
                    z <= (w_count == 2'b10) ? 1'b1 : 1'b0;
                    cycle_count <= 2'b00; // Reset cycle counter
                    w_count <= 2'b00; // Reset w count
                end
            end
        end
    end

    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (s) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_A;
                end
            end
            STATE_B: begin
                next_state = STATE_B; // Remain in state B
            end
            default: begin
                next_state = STATE_A;
            end
        endcase
    end

endmodule
[DONE]
```