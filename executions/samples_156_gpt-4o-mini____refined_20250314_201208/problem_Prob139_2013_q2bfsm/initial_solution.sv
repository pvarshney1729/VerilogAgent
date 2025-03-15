[BEGIN]
```verilog
module TopModule (
    input  logic clk,
    input  logic resetn,
    input  logic x,
    input  logic y,
    output logic f,
    output logic g
);

    typedef enum logic [2:0] {
        STATE_A,
        STATE_B,
        STATE_C,
        STATE_D
    } state_t;

    state_t current_state, next_state;
    logic [2:0] x_counter; // To count the occurrences of x = 1, 0, 1
    logic y_detected;

    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            x_counter <= 3'b000;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_A) begin
                f <= 1'b0;
                g <= 1'b0;
                x_counter <= 3'b000;
            end else if (current_state == STATE_B) begin
                f <= 1'b1;
                x_counter <= {x_counter[1:0], x}; // Shift in the current x value
            end else if (current_state == STATE_C) begin
                g <= 1'b1;
            end else if (current_state == STATE_D) begin
                if (y_detected) begin
                    g <= 1'b1;
                end else begin
                    g <= 1'b0;
                end
            end
        end
    end

    always_comb begin
        case (current_state)
            STATE_A: begin
                next_state = STATE_B;
            end
            STATE_B: begin
                if (x_counter == 3'b101) begin
                    next_state = STATE_C;
                end else begin
                    next_state = STATE_B;
                end
            end
            STATE_C: begin
                next_state = STATE_D; // Move to STATE_D to check y
            end
            STATE_D: begin
                next_state = (y == 1'b1) ? STATE_D : STATE_D; // Stay in STATE_D
            end
            default: next_state = STATE_A;
        endcase
    end

    always_ff @(posedge clk) begin
        if (current_state == STATE_C) begin
            y_detected <= (y == 1'b1);
        end else begin
            y_detected <= 1'b0;
        end
    end

endmodule
```
[DONE]